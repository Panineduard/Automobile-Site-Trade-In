package com.dao;

import com.dao.configuration.files.HibernateUtil;
import com.models.TempImg;
import com.service.ChangeImgSize;
import com.setting.Setting;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by volkswagen1 on 17.07.2016.
 */
@Repository
public class TempPhotoDAO {
    @Autowired
    ChangeImgSize changeImgSize;
    public int putTempPhoto(MultipartFile photo,  String formatFile,String idSession,int position) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tr =session.beginTransaction();
        Integer id=-1;
        try {
            TempImg tempImg=new TempImg();
            tempImg.setIdSession(idSession);
            tempImg.setDateMade(new Date());
            tempImg.setPosition(position);
            id=(Integer)session.save(tempImg);
            String path=Setting.getTempFolder()+id+formatFile;
                File file =new File(path);
            session.createQuery("update TempImg set path=:path where id=:id")
                    .setParameter("path", file.getAbsolutePath())
                    .setParameter("id", id)
                    .executeUpdate();
            tr.commit();
            BufferedImage bufferedImage =  ImageIO.read(photo.getInputStream());
            if(bufferedImage.getHeight()>=bufferedImage.getWidth()){
                Integer width= (int)((double)(bufferedImage.getWidth()) / ((double)bufferedImage.getHeight() / Setting.get_IMG_HEIGHT()));
                if(width==0)width=Setting.get_IMG_WIDTH();
                bufferedImage=changeImgSize.resizeImage(bufferedImage,width,Setting.get_IMG_HEIGHT());
            }
            else {
                Integer height= (int)((double)(bufferedImage.getHeight()) / ((double)bufferedImage.getWidth() / Setting.get_IMG_WIDTH()));
                if(height==0)height=Setting.get_IMG_HEIGHT();
                bufferedImage=changeImgSize.resizeImage(bufferedImage,Setting.get_IMG_WIDTH(),height);
            }
                ImageIO.write(bufferedImage, formatFile.toLowerCase().substring(1), file);
        }
        catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
        return id;
    }
    public void deleteDataByIdSession(String idSession){
        Session session=HibernateUtil.getSessionFactory().openSession();
        Transaction transaction=session.beginTransaction();
        List<String> paths=session.createQuery("select path from TempImg where idSession=:id")
                .setParameter("id",idSession)
                .list();

        paths.forEach(path->{
            File file=new File(path);
            if (file.exists())file.delete();
        });

        session.createQuery("delete TempImg where idSession=:idSession")
                .setParameter("idSession",idSession)
                .executeUpdate();
        transaction.commit();
        if(session.isOpen())session.close();
    }
//    public static void main(String...aegs){
//        new TempPhotoDAO().deleteDataByScheduler();
//    }
    public void deleteDataByScheduler(){
        Calendar calendar=Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_WEEK, -1);
        Date date =calendar.getTime();
       Session session=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction=session.beginTransaction();
        List<TempImg> tempImgs=session.createQuery("from TempImg where dateMade<:date")
                .setParameter("date", date)
                .list();
        session.createQuery("delete from TempImg where dateMade<:date")
                .setParameter("date",date)
                .executeUpdate();

        tempImgs.forEach(img->{
            File file=new File(img.getPath());
            if(file.exists()){
                file.delete();
            }
        });
        transaction.commit();
    }

}
