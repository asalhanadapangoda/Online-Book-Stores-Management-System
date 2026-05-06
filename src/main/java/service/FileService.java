package service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileService {
    // Point this to your actual project folder to save data permanently in your
    // editor
    public static final String DATA_PATH = "C:\\Users\\User\\Desktop\\ Online Book Store\\data\\";

    public static List<String> readAllLines(String filePath) {
        List<String> lines = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) {
            return lines;
        }
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return lines;
    }

    public static void appendLine(String filePath, String line) {
        try (PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(filePath, true)))) {
            out.println(line);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void writeAllLines(String filePath, List<String> lines) {
        try (PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(filePath)))) {
            for (String line : lines) {
                out.println(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
