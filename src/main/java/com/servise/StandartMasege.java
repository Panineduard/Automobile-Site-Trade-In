package com.servise;

import com.sun.xml.internal.bind.api.impl.NameConverter;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.List;
import java.util.function.BiPredicate;
import java.util.stream.Stream;

/**
 * Created by volkswagen1 on 11.01.2016.
 */
public class StandartMasege {
    BiPredicate <Path,BasicFileAttributes> fileAttributesBiPredicate=(path,attr)->{
        PathMatcher matcher= FileSystems.getDefault().getPathMatcher("");
        return matcher.matches(path);
    };
//    public static List<String> finedMesege(String number,Stream<Path>files,int lines){
//        return files
//                .<String>flatMap(StandartMasege::linesOfFile);
////                .filter()
//    }
    public static Stream<String> linesOfFile(Path file){
        try {
            return Files.lines(file, StandardCharsets.UTF_8);
        } catch (IOException e) {
            e.printStackTrace();
            return Stream.empty();
        }
    }
}
