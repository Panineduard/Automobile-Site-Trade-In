package com.helpers;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * Created by volkswagen1 on 08.12.2015.
 */
public class FileUploadForm {
    private List<MultipartFile> files;

    public List<MultipartFile> getFiles() {
        return files;
    }

    public void setFiles(List<MultipartFile> files) {
        this.files = files;
    }
    //Getter and setter methods
}
