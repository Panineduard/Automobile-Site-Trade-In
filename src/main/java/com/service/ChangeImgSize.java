package com.service;


import org.springframework.stereotype.Component;

import java.awt.*;
import java.awt.image.BufferedImage;

/**
 * Created by volkswagen1 on 11.01.2016.
 */
@Component
public class ChangeImgSize {
    public BufferedImage resizeImage(BufferedImage originalImage,Integer IMG_WIDTH,Integer IMG_HEIGHT){
        int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
        BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
        g.dispose();
        return resizedImage;
    }
    public BufferedImage resizeImage(BufferedImage originalImage,Integer resizePercentage){
        Integer IMG_WIDTH=(originalImage.getWidth()*resizePercentage)/100;
        Integer IMG_HEIGHT=(originalImage.getHeight()*resizePercentage)/100;
        int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
        BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
        g.dispose();
        return resizedImage;
    }
}
