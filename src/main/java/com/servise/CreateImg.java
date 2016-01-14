package com.servise;

import java.awt.*;
import java.awt.image.BufferedImage;

/**
 * Created by volkswagen1 on 11.01.2016.
 */
public class CreateImg {
    public static BufferedImage resizeImage(BufferedImage originalImage,Integer IMG_WIDTH,Integer IMG_HEIGHT){
        int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
        BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
        g.dispose();
        return resizedImage;
    }
}
