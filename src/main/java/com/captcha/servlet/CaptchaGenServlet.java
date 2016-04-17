package com.captcha.servlet;

import com.captcha.util.Util;
import com.helpers.PasswordHelper;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

public class CaptchaGenServlet extends HttpServlet {

    public static final String FILE_TYPE = "jpeg";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Max-Age", 0);

        String captchaStr="";

        //captchaStr=Util.generateCaptchaTextMethod();

        captchaStr=Util.generateCaptchaTextMethod2(6);

        try {

            int width=150;      int height=50;

            Color bg = new Color(218,225,243);
            Color fg = new Color(0,100,0);
//            Jokerman,Arial
            Font font = new Font("Bradley Hand ITC", Font.BOLD, 30);
            BufferedImage cpimg =new BufferedImage(width,height,BufferedImage.OPAQUE);
            Graphics g = cpimg.createGraphics();

            g.setFont(font);
            g.setColor(bg);

            g.fillRect(0, 0, width, height);
            g.setColor(fg);
            g.drawString(captchaStr, 5, 35);
            PasswordHelper passwordHelper=new PasswordHelper();
            HttpSession session = request.getSession(true);
            session.setAttribute("CAPTCHA", passwordHelper.encode(captchaStr));//Her we add Captcha in session!!!!

            OutputStream outputStream = response.getOutputStream();

            ImageIO.write(cpimg, FILE_TYPE, outputStream);
            outputStream.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

}