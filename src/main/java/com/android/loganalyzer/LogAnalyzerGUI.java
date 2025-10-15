package com.android.loganalyzer;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.LineIterator;

import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Android Log Analyzer GUI 버전
 */
public class LogAnalyzerGUI extends JFrame {
    
    // ANR 패턴들
    private static final Pattern ANR_PATTERN = Pattern.compile(
        "(?i)(anr|application not responding|not responding)",
        Pattern.CASE_INSENSITIVE
    );
    
    // Exception 패턴들
    private static final Pattern EXCEPTION_PATTERN = Pattern.compile(
        "(?i)(exception|error|fatal|crash|outofmemory|stackoverflow)",
        Pattern.CASE_INSENSITIVE
    );
    
    // Exception 타입을 추출하는 패턴
    private static final Pattern EXCEPTION_TYPE_PATTERN = Pattern.compile(
        "(?i)([a-zA-Z_$][a-zA-Z0-9_$]*\\.?[a-zA-Z_$][a-zA-Z0-9_$]*Exception|[a-zA-Z_$][a-zA-Z0-9_$]*\\.?[a-zA-Z_$][a-zA-Z0-9_$]*Error)",
        Pattern.CASE_INSENSITIVE
    );
    
    private JTextArea resultArea;
    private JProgressBar progressBar;
    private JLabel statusLabel;
    private JButton analyzeButton;
    private JButton selectFileButton;
    private JTextField filePathField;
    
    public LogAnalyzerGUI() {
        initializeGUI();
    }
    
    private void initializeGUI() {
        setTitle("Android Log Analyzer");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());
        
        // 상단 패널
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.setBorder(BorderFactory.createTitledBorder("로그 파일 선택"));
        
        filePathField = new JTextField();
        filePathField.setEditable(false);
        
        selectFileButton = new JButton("파일 선택");
        selectFileButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                selectLogFile();
            }
        });
        
        JPanel filePanel = new JPanel(new BorderLayout());
        filePanel.add(filePathField, BorderLayout.CENTER);
        filePanel.add(selectFileButton, BorderLayout.EAST);
        
        topPanel.add(filePanel, BorderLayout.CENTER);
        
        // 중간 패널
        JPanel middlePanel = new JPanel(new BorderLayout());
        middlePanel.setBorder(BorderFactory.createTitledBorder("분석 결과"));
        
        resultArea = new JTextArea(20, 60);
        resultArea.setEditable(false);
        resultArea.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 12));
        JScrollPane scrollPane = new JScrollPane(resultArea);
        
        middlePanel.add(scrollPane, BorderLayout.CENTER);
        
        // 하단 패널
        JPanel bottomPanel = new JPanel(new BorderLayout());
        
        // 진행률 표시
        progressBar = new JProgressBar();
        progressBar.setStringPainted(true);
        progressBar.setString("대기 중...");
        
        statusLabel = new JLabel("로그 파일을 선택하세요");
        
        analyzeButton = new JButton("분석 시작");
        analyzeButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                analyzeLogFile();
            }
        });
        analyzeButton.setEnabled(false);
        
        JPanel buttonPanel = new JPanel(new FlowLayout());
        buttonPanel.add(analyzeButton);
        
        bottomPanel.add(progressBar, BorderLayout.NORTH);
        bottomPanel.add(statusLabel, BorderLayout.CENTER);
        bottomPanel.add(buttonPanel, BorderLayout.SOUTH);
        
        // 메인 프레임에 패널 추가
        add(topPanel, BorderLayout.NORTH);
        add(middlePanel, BorderLayout.CENTER);
        add(bottomPanel, BorderLayout.SOUTH);
        
        pack();
        setLocationRelativeTo(null);
    }
    
    private void selectLogFile() {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setDialogTitle("로그 파일 선택");
        fileChooser.setFileFilter(new FileNameExtensionFilter("텍스트 파일 (*.txt, *.log)", "txt", "log"));
        fileChooser.setFileFilter(new FileNameExtensionFilter("모든 파일 (*.*)", "*"));
        
        int result = fileChooser.showOpenDialog(this);
        if (result == JFileChooser.APPROVE_OPTION) {
            File selectedFile = fileChooser.getSelectedFile();
            filePathField.setText(selectedFile.getAbsolutePath());
            analyzeButton.setEnabled(true);
            statusLabel.setText("분석할 준비가 되었습니다");
        }
    }
    
    private void analyzeLogFile() {
        String filePath = filePathField.getText();
        if (filePath.isEmpty()) {
            JOptionPane.showMessageDialog(this, "로그 파일을 선택하세요", "오류", JOptionPane.ERROR_MESSAGE);
            return;
        }
        
        File logFile = new File(filePath);
        if (!logFile.exists()) {
            JOptionPane.showMessageDialog(this, "파일을 찾을 수 없습니다: " + filePath, "오류", JOptionPane.ERROR_MESSAGE);
            return;
        }
        
        // UI 비활성화
        analyzeButton.setEnabled(false);
        selectFileButton.setEnabled(false);
        resultArea.setText("");
        
        // 백그라운드에서 분석 실행
        SwingWorker<AnalysisResult, String> worker = new SwingWorker<AnalysisResult, String>() {
            @Override
            protected AnalysisResult doInBackground() throws Exception {
                return analyzeLogFileInBackground(logFile);
            }
            
            @Override
            protected void process(List<String> chunks) {
                for (String chunk : chunks) {
                    resultArea.append(chunk + "\n");
                }
            }
            
            @Override
            protected void done() {
                try {
                    AnalysisResult result = get();
                    displayResults(result);
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(LogAnalyzerGUI.this, 
                        "분석 중 오류가 발생했습니다: " + e.getMessage(), 
                        "오류", JOptionPane.ERROR_MESSAGE);
                } finally {
                    // UI 활성화
                    analyzeButton.setEnabled(true);
                    selectFileButton.setEnabled(true);
                    progressBar.setString("완료");
                    statusLabel.setText("분석이 완료되었습니다");
                }
            }
        };
        
        worker.execute();
    }
    
    private AnalysisResult analyzeLogFileInBackground(File logFile) throws IOException {
        Map<String, Integer> anrCounts = new HashMap<>();
        Map<String, Integer> exceptionCounts = new HashMap<>();
        int totalAnrCount = 0;
        int totalExceptionCount = 0;
        
        // publish 메서드는 SwingWorker에서만 사용 가능하므로 제거
        // publish("로그 파일 분석 시작: " + logFile.getName());
        // publish("파일 크기: " + FileUtils.byteCountToDisplaySize(logFile.length()));
        // publish("분석 중...\n");
        
        // FileUtils.lineCount는 존재하지 않으므로 다른 방법 사용
        long totalLines = 0;
        try (LineIterator countIt = FileUtils.lineIterator(logFile, "UTF-8")) {
            while (countIt.hasNext()) {
                countIt.nextLine();
                totalLines++;
            }
        }
        long processedLines = 0;
        
        try (LineIterator it = FileUtils.lineIterator(logFile, "UTF-8")) {
            while (it.hasNext()) {
                String line = it.nextLine();
                processedLines++;
                
                // ANR 검사
                if (ANR_PATTERN.matcher(line).find()) {
                    totalAnrCount++;
                    String anrType = extractAnrType(line);
                    anrCounts.merge(anrType, 1, Integer::sum);
                }
                
                // Exception 검사
                if (EXCEPTION_PATTERN.matcher(line).find()) {
                    totalExceptionCount++;
                    String exceptionType = extractExceptionType(line);
                    exceptionCounts.merge(exceptionType, 1, Integer::sum);
                }
                
                // 진행률 업데이트
                final int progress = (int) ((processedLines * 100) / totalLines);
                final long currentProcessedLines = processedLines;
                final long currentTotalLines = totalLines;
                SwingUtilities.invokeLater(() -> {
                    progressBar.setValue(progress);
                    progressBar.setString(progress + "%");
                    statusLabel.setText("분석 중... (" + currentProcessedLines + "/" + currentTotalLines + "줄)");
                });
            }
        }
        
        return new AnalysisResult(anrCounts, exceptionCounts, totalAnrCount, totalExceptionCount);
    }
    
    private String extractAnrType(String line) {
        if (line.toLowerCase().contains("anr")) {
            return "ANR";
        } else if (line.toLowerCase().contains("not responding")) {
            return "Application Not Responding";
        }
        return "Unknown ANR";
    }
    
    private String extractExceptionType(String line) {
        Matcher matcher = EXCEPTION_TYPE_PATTERN.matcher(line);
        if (matcher.find()) {
            return matcher.group(1);
        }
        
        String lowerLine = line.toLowerCase();
        if (lowerLine.contains("outofmemory")) {
            return "OutOfMemoryError";
        } else if (lowerLine.contains("stackoverflow")) {
            return "StackOverflowError";
        } else if (lowerLine.contains("fatal")) {
            return "Fatal Error";
        } else if (lowerLine.contains("crash")) {
            return "Crash";
        }
        
        return "Unknown Exception";
    }
    
    private void displayResults(AnalysisResult result) {
        StringBuilder sb = new StringBuilder();
        sb.append("=".repeat(60)).append("\n");
        sb.append("📊 로그 분석 결과\n");
        sb.append("=".repeat(60)).append("\n\n");
        
        // ANR 결과
        sb.append("🚨 ANR (Application Not Responding) 분석:\n");
        sb.append("-".repeat(40)).append("\n");
        if (result.anrCounts.isEmpty()) {
            sb.append("ANR이 발견되지 않았습니다.\n");
        } else {
            sb.append(String.format("총 ANR 발생 횟수: %d회\n\n", result.totalAnrCount));
            sb.append("ANR 타입별 상세:\n");
            result.anrCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .forEach(entry -> sb.append(String.format("  • %s: %d회\n", entry.getKey(), entry.getValue())));
        }
        
        // Exception 결과
        sb.append("\n💥 Exception 분석:\n");
        sb.append("-".repeat(40)).append("\n");
        if (result.exceptionCounts.isEmpty()) {
            sb.append("Exception이 발견되지 않았습니다.\n");
        } else {
            sb.append(String.format("총 Exception 발생 횟수: %d회\n\n", result.totalExceptionCount));
            sb.append("Exception 타입별 상세:\n");
            result.exceptionCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .forEach(entry -> sb.append(String.format("  • %s: %d회\n", entry.getKey(), entry.getValue())));
        }
        
        // 요약
        sb.append("\n📈 요약:\n");
        sb.append("-".repeat(40)).append("\n");
        sb.append(String.format("총 문제 발생 횟수: %d회\n", result.totalAnrCount + result.totalExceptionCount));
        sb.append(String.format("  - ANR: %d회\n", result.totalAnrCount));
        sb.append(String.format("  - Exception: %d회\n", result.totalExceptionCount));
        
        if (result.totalAnrCount + result.totalExceptionCount > 0) {
            double anrRatio = (double) result.totalAnrCount / (result.totalAnrCount + result.totalExceptionCount) * 100;
            double exceptionRatio = (double) result.totalExceptionCount / (result.totalAnrCount + result.totalExceptionCount) * 100;
            sb.append(String.format("ANR 비율: %.1f%%\n", anrRatio));
            sb.append(String.format("Exception 비율: %.1f%%\n", exceptionRatio));
        }
        
        resultArea.setText(sb.toString());
    }
    
    public static void main(String[] args) {
        // Look and Feel 설정
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        SwingUtilities.invokeLater(() -> {
            new LogAnalyzerGUI().setVisible(true);
        });
    }
    
    private static class AnalysisResult {
        final Map<String, Integer> anrCounts;
        final Map<String, Integer> exceptionCounts;
        final int totalAnrCount;
        final int totalExceptionCount;
        
        AnalysisResult(Map<String, Integer> anrCounts, Map<String, Integer> exceptionCounts, 
                      int totalAnrCount, int totalExceptionCount) {
            this.anrCounts = anrCounts;
            this.exceptionCounts = exceptionCounts;
            this.totalAnrCount = totalAnrCount;
            this.totalExceptionCount = totalExceptionCount;
        }
    }
}

