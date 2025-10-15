package com.android.loganalyzer;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.LineIterator;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 갤럭시 핸드폰 덤프로그에서 ANR과 Exception을 분석하는 메인 클래스
 */
public class LogAnalyzer {
    
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
    
    private final Map<String, Integer> anrCounts = new HashMap<>();
    private final Map<String, Integer> exceptionCounts = new HashMap<>();
    private int totalAnrCount = 0;
    private int totalExceptionCount = 0;
    
    /**
     * 로그 파일을 분석합니다.
     * 
     * @param logFilePath 분석할 로그 파일 경로
     * @throws IOException 파일 읽기 오류
     */
    public void analyzeLogFile(String logFilePath) throws IOException {
        File logFile = new File(logFilePath);
        
        if (!logFile.exists()) {
            throw new IOException("로그 파일을 찾을 수 없습니다: " + logFilePath);
        }
        
        System.out.println("로그 파일 분석 시작: " + logFile.getName());
        System.out.println("파일 크기: " + FileUtils.byteCountToDisplaySize(logFile.length()));
        System.out.println("분석 중...");
        
        try (LineIterator it = FileUtils.lineIterator(logFile, "UTF-8")) {
            int lineNumber = 0;
            
            while (it.hasNext()) {
                String line = it.nextLine();
                lineNumber++;
                
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
                
                // 진행 상황 표시 (매 10000줄마다)
                if (lineNumber % 10000 == 0) {
                    System.out.print(".");
                    if (lineNumber % 100000 == 0) {
                        System.out.println(" (" + lineNumber + "줄 처리됨)");
                    }
                }
            }
        }
        
        System.out.println("\n분석 완료!");
    }
    
    /**
     * ANR 타입을 추출합니다.
     */
    private String extractAnrType(String line) {
        if (line.toLowerCase().contains("anr")) {
            return "ANR";
        } else if (line.toLowerCase().contains("not responding")) {
            return "Application Not Responding";
        }
        return "Unknown ANR";
    }
    
    /**
     * Exception 타입을 추출합니다.
     */
    private String extractExceptionType(String line) {
        Matcher matcher = EXCEPTION_TYPE_PATTERN.matcher(line);
        if (matcher.find()) {
            return matcher.group(1);
        }
        
        // 패턴이 매치되지 않으면 일반적인 키워드로 분류
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
    
    /**
     * 분석 결과를 출력합니다.
     */
    public void printResults() {
        System.out.println("\n" + "=".repeat(60));
        System.out.println("📊 로그 분석 결과");
        System.out.println("=".repeat(60));
        
        // ANR 결과
        System.out.println("\n🚨 ANR (Application Not Responding) 분석:");
        System.out.println("-".repeat(40));
        if (anrCounts.isEmpty()) {
            System.out.println("ANR이 발견되지 않았습니다.");
        } else {
            System.out.printf("총 ANR 발생 횟수: %d회\n", totalAnrCount);
            System.out.println("\nANR 타입별 상세:");
            anrCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .forEach(entry -> System.out.printf("  • %s: %d회\n", entry.getKey(), entry.getValue()));
        }
        
        // Exception 결과
        System.out.println("\n💥 Exception 분석:");
        System.out.println("-".repeat(40));
        if (exceptionCounts.isEmpty()) {
            System.out.println("Exception이 발견되지 않았습니다.");
        } else {
            System.out.printf("총 Exception 발생 횟수: %d회\n", totalExceptionCount);
            System.out.println("\nException 타입별 상세:");
            exceptionCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .forEach(entry -> System.out.printf("  • %s: %d회\n", entry.getKey(), entry.getValue()));
        }
        
        // 요약
        System.out.println("\n📈 요약:");
        System.out.println("-".repeat(40));
        System.out.printf("총 문제 발생 횟수: %d회\n", totalAnrCount + totalExceptionCount);
        System.out.printf("  - ANR: %d회\n", totalAnrCount);
        System.out.printf("  - Exception: %d회\n", totalExceptionCount);
        
        if (totalAnrCount + totalExceptionCount > 0) {
            System.out.printf("ANR 비율: %.1f%%\n", (double) totalAnrCount / (totalAnrCount + totalExceptionCount) * 100);
            System.out.printf("Exception 비율: %.1f%%\n", (double) totalExceptionCount / (totalAnrCount + totalExceptionCount) * 100);
        }
    }
    
    /**
     * 메인 메서드
     */
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("사용법: java -jar log-analyzer.jar <로그파일경로>");
            System.out.println("예시: java -jar log-analyzer.jar dumpstate.txt");
            return;
        }
        
        String logFilePath = args[0];
        LogAnalyzer analyzer = new LogAnalyzer();
        
        try {
            long startTime = System.currentTimeMillis();
            analyzer.analyzeLogFile(logFilePath);
            long endTime = System.currentTimeMillis();
            
            analyzer.printResults();
            
            System.out.println("\n⏱️  분석 소요 시간: " + (endTime - startTime) + "ms");
            
        } catch (IOException e) {
            System.err.println("오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
