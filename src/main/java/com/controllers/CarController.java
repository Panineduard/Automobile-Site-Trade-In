package com.controllers;

import com.dao.AdminServiceDAO;
import com.dao.TempPhotoDAO;
import com.helpers.ResultCars;
import com.helpers.EncoderId;
import com.helpers.FileUploadForm;
import com.dao.CarDAO;
import com.dao.DealerDao;
import com.helpers.SearchOptions;
import com.modelClass.*;
import com.servise.ChangeImgSize;
import com.servise.StandartMasege;
import com.setting.Setting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.helpers.ViewHalper;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;

/**
 * Created by Эдуард on 30.11.15.
 */
@Controller
public class CarController {
    @Autowired
    EncoderId encoderId;
    @Autowired
    CarDAO carDAO;
    @Autowired
    TempPhotoDAO tempPhotoDAO;
    @Autowired
    AdminServiceDAO adminServiceDAO;
    @Autowired
    DealerDao dealerDao;
    @Autowired
    StandartMasege standartMasege;
    @Autowired
    ChangeImgSize changeImgSize;
    @Autowired
    ViewHalper viewHalper;
    private String path =this.getClass().getClassLoader().getResource("notAvailable.png").getPath();

    //free methods

    @RequestMapping(value = "/getRegions",method = RequestMethod.GET, headers="Accept=application/json")
    public @ResponseBody
    List<Region> getModelForm(){
        return adminServiceDAO.getRegions();
    }
    @RequestMapping(value = "/getYears",method = RequestMethod.GET, headers="Accept=application/json")
    public @ResponseBody
    List<Integer> getYears(){
        return carDAO.getYears();
    }
    @RequestMapping(value = "/getBrands",method = RequestMethod.GET, headers="Accept=application/json")
    public @ResponseBody
    List<Brand> getBrands(){
        return carDAO.getBrands();
    }
    @RequestMapping(value = "/getPhoto", method = RequestMethod.GET)
    public void getPhoto(HttpServletRequest req, HttpServletResponse response){
        String path_of_photo=(String)req.getParameter("pathPhoto");

        Integer percentage=0;
        try {

        if(req.getParameter("percentage_of_reduction")!=null){
            percentage=new Integer(req.getParameter("percentage_of_reduction"));

        }
        }
        catch (ClassCastException e){
            System.out.println("exeption in car contpoller param");
        }
        finally {


        if(req.getParameter("pathPhoto")!=null&&!req.getParameter("pathPhoto").isEmpty()){

                try {
                    File file=new File(path_of_photo);
                    if(file.length()==0){
                        file=new File(path);
                        percentage=0;
                    }
                    BufferedImage bufferedImage =  ImageIO.read(file);
                    if(percentage!=0){
                        bufferedImage = changeImgSize.resizeImage(bufferedImage,percentage);
                    }

                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    ImageIO.write(bufferedImage,"jpg",baos);
                    baos.flush();
                    byte[] imageInByte = baos.toByteArray();
                    baos.close();

                    response.setContentType("image/jpg");
                    response.getOutputStream().write(imageInByte);
                    response.getOutputStream().flush();
                    response.getOutputStream().close();
                }

                catch(FileNotFoundException fe){
                    fe.printStackTrace();
                }
                catch (IOException r){
                    r.printStackTrace();
                System.out.println("Ошибка потока getPhoto");
                }
        }
        }
    }

    @RequestMapping(value = "/putPhoto",method = RequestMethod.POST,headers ="Accept=application/json" )
    public @ResponseBody Integer putPhoto(@ModelAttribute("file") MultipartFile file,@ModelAttribute("type")String type,
            @ModelAttribute("position")String position,HttpSession session){
        int idPhoto=-1;
        int pointPosition= type.lastIndexOf(".");
        String formatFile =type.substring(pointPosition);
        if(position==null)position=new String("-1");
           idPhoto= tempPhotoDAO.putTempPhoto(file,formatFile,session.getId(),new Integer(position));
        return idPhoto;
    }

    @RequestMapping(value = "/getModelByBrand",method = RequestMethod.GET, headers="Accept=application/json")
    public @ResponseBody List<String> getModelForm(@ModelAttribute("model")String model){
        return carDAO.getModelByBrand(model);
    }

    @RequestMapping(value = "/getSearchOptions",method = RequestMethod.GET, headers="Accept=application/json")
    public @ResponseBody
    SearchOptions getModelForm(HttpSession session){
        SearchOptions options = (SearchOptions)session.getAttribute("options");
        return options;
    }
    @RequestMapping(value = "/ascending_price")
    public ModelAndView sortedCarsAp(HttpSession session){
        ResultCars result;
        SearchOptions options=(SearchOptions)session.getAttribute("options");
        Integer page=(Integer)session.getAttribute("page");
        if (options!=null){
            if (page==null){page=1;}
            if(options.getPrise()!=1){
                options.setPrise(1);
                result= carDAO.getCarsByParameters(options,page);
                session.setAttribute("cars",result.getCars());
                session.setAttribute("page",result.getPage());
                session.setAttribute("options",options);
            }
        }
        else {
            options=new SearchOptions("","","","","","","","","",1);
            result=carDAO.getCarsByParameters(options,1);
            session.setAttribute("cars", result.getCars());
            session.setAttribute("page",result.getPage());
            session.setAttribute("options",options);
//            List<Car>cars = (List<Car>)session.getAttribute("cars");
//            if(cars!=null){ Collections.sort(cars,(Car c1,Car c2)->c1.getPrise().compareTo(c2.getPrise()));
//                session.setAttribute("cars",cars);
//            }
        }
        ModelAndView modelAndView = new ModelAndView("index");
        return modelAndView;
    }

    @RequestMapping(value = "/by_prices_descending")
    public ModelAndView sortedCarsDown(HttpSession session){
        ResultCars result;
        SearchOptions options=(SearchOptions)session.getAttribute("options");
        Integer page=(Integer)session.getAttribute("page");
        if (options!=null){
            if (page==null){page=1;}
            if(options.getPrise()!=2){
                options.setPrise(2);
                result= carDAO.getCarsByParameters(options,page);
                session.setAttribute("cars",result.getCars());
                session.setAttribute("page",result.getPage());
                session.setAttribute("options",options);
            }
        }
        else {
            options=new SearchOptions("","","","","","","","","",2);
            result=carDAO.getCarsByParameters(options,1);
//            List<Car>cars = (List<Car>)session.getAttribute("cars");
//            if(cars!=null){        Collections.sort(cars,(Car c1,Car c2)->-(c1.getPrise().compareTo(c2.getPrise())));
                session.setAttribute("cars",result.getCars());
                session.setAttribute("page",result.getPage());
                session.setAttribute("options",options);
//            }
        }

        ModelAndView modelAndView = new ModelAndView("index");
        return modelAndView;
    }
    @RequestMapping(value = "/lookForCars",method = RequestMethod.POST)
    public ModelAndView lookForCars(
            @ModelAttribute("make")String make,@ModelAttribute("model")String model,
            @ModelAttribute("price_from")String price_from,@ModelAttribute("price_to")String price_to,
            @ModelAttribute("year_from")String year_from,@ModelAttribute("year_to")String year_to,
            @ModelAttribute("engine")String engine,@ModelAttribute("gearbox")String gearbox,
            @ModelAttribute("region")String region,
            @ModelAttribute("page")String page,HttpSession session,ModelMap firstSearchOptions){
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addAllObjects(firstSearchOptions);
        if(page.isEmpty()){
            page="1";
        }
        SearchOptions options=(SearchOptions)session.getAttribute("options");
        if(options!=null){
            options=new SearchOptions(make,model,price_from,price_to,year_from,year_to,engine,gearbox,region,options.getPrise());
        }
        else {
            options =new SearchOptions(make,model,price_from,price_to,year_from,year_to,engine,gearbox,region,0);
        }

        ResultCars cars =carDAO.getCarsByParameters(options,new Integer(page));
        session.setAttribute("options",options);
        session.setAttribute("cars",cars.getCars());
        session.setAttribute("page",cars.getPage());
        session.setAttribute("pages", cars.getPages());
        return modelAndView;
    }
    @RequestMapping(value = "/replacing_the_page_number", method = RequestMethod.GET)
    public ModelAndView replacePage(@RequestParam("page") Integer page,HttpSession session){
        SearchOptions options=(SearchOptions)session.getAttribute("options");
        if(options!=null){
            ResultCars result=carDAO.getCarsByParameters(options, page);
            session.setAttribute("page",  result.getPage());
            session.setAttribute("cars",  result.getCars());
            session.setAttribute("pages", result.getPages());
        }

        ModelAndView modelAndView = new ModelAndView("index");
        return modelAndView;
    }
    @RequestMapping(value = "/carPage",method = RequestMethod.GET)
    public ModelAndView getDealer(@RequestParam ("idCar") String idCar,HttpSession session){
        ModelAndView modelAndView= new ModelAndView("auto");
        Car car=null;
        Dealer dealer=null;
        idCar = encoderId.decodeID(idCar);
        if(!idCar.isEmpty()){
            car=carDAO.getCarById(idCar);
            if(car!=null) {
                carDAO.updateViews(idCar);
                dealer = dealerDao.getDealerById(car.getIdDealer());
            }
            modelAndView.addObject("car", car);
            modelAndView.addObject("dealer",dealer);
        }

        if(car==null||dealer==null){
            ModelAndView modelAndView1= new ModelAndView("successfulRegistration");
            modelAndView1.addObject("msg", standartMasege.getMessage(44));
            return modelAndView1;
        }
        return modelAndView;
    }
    @RequestMapping(value = "/resetSearchOptions", method = RequestMethod.GET)
    public ModelAndView resetSearchOptions(HttpSession session){
//        session.removeAttribute("options");

        session.removeAttribute("cars");
        session.removeAttribute("options");
        session.removeAttribute("pages");
        session.removeAttribute("page");
        SearchOptions options=new SearchOptions();
        ResultCars result= carDAO.getCarsByParameters(options, 1);
        session.setAttribute("options",options);
        session.setAttribute("cars", result.getCars());
        session.setAttribute("page", result.getPage());
        session.setAttribute("cars", result.getCars());
        session.setAttribute("pages", result.getPages());
//        session.setAttribute("cars",carDAO.getLastCars(5));
        return new ModelAndView("index");
    }



    //security methods

    @RequestMapping(value = "/getCarsOptions",method = RequestMethod.GET, headers="Accept=application/json")
    public @ResponseBody
        Car getCarsOptions(HttpSession session){
        Car car=(Car)session.getAttribute("chCar");
        return car;
    }
    @RequestMapping(value = "/addCar")
    public ModelAndView getLoginForm(){
        ModelAndView modelAndView = new ModelAndView("pageForCar");
        return modelAndView;
    }

    @RequestMapping(value = "*/update_car")
    public ModelAndView updateCarsDateProvide(@ModelAttribute("car")String id){
        carDAO.updateDateProvideDyId(new Long(encoderId.decodeID(id)));
        ModelAndView modelAndView=new ModelAndView("my_account");
        return viewHalper.addingDealerAndCarsInView(modelAndView);
    }



    @RequestMapping(value = "/delete_photo", method = RequestMethod.GET)
    public void deletePhoto(@RequestParam("count_of_photo") Integer countOfPhoto,@RequestParam("id_car") Integer idCar){
          carDAO.deletePhotoByCarsId(idCar, countOfPhoto);

    }
    @RequestMapping(value = {"*/addCarWithPhoto","/addCarWithPhoto"},method = RequestMethod.POST)
    //@ModelAttribute("uploadForm") FileUploadForm inputUploadForm,
    public ModelAndView uploadCarsFile(HttpServletRequest request,@ModelAttribute("count_of_photo")String countOfPhoto,
                                          @ModelAttribute("make")String make,@ModelAttribute("model")String model,
                                          @ModelAttribute("prise")String prise,@ModelAttribute("year_prov")String year_prov,
                                          @ModelAttribute("engine")String engine,@ModelAttribute("gearbox")String gearbox,
                                          @ModelAttribute("mileage")String mileage,@ModelAttribute("comment")String comment,
                                          @ModelAttribute("engine_capacity")String engine_capacity,@ModelAttribute("id_car")String idCar,
                                          @ModelAttribute("region")String region,@ModelAttribute("equipment")String equipment,HttpSession session) {
        String nullMsg="Data not available.";
        session.removeAttribute("chCar");
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer = auth.getName();
//        List<MultipartFile>files=new ArrayList<>();
        List<Integer> idPhotos=new ArrayList<>();
        if (!countOfPhoto.isEmpty()){
            int count=new Integer(countOfPhoto);
            for (int i=1;i<=count;i++){
                String idString=request.getParameter("photo"+i);
                if(idString!=null){
                    idPhotos.add(new Integer(idString));
                }
            }
        }

//        if(inputUploadForm==null){
//            System.out.println("Empty!!");
//        }
//        inputUploadForm.getFiles().forEach(f->{
//            if(f.getSize()>0){
//                files.add(f);
//            }
//        });
//        FileUploadForm uploadForm =new FileUploadForm();
//        uploadForm.setFiles(files);
        boolean update=false;

        if (!idDealer.isEmpty()) {
            Car car = new Car();
            if(!idCar.isEmpty()){
                car=carDAO.getCarById(encoderId.decodeID(idCar));
                update=true;
                 }
            else {
                car.setIdDealer(idDealer);
            }


            if (!make.isEmpty()) {
                car.setBrand(make);

            if (!model.isEmpty()) {
                car.setModel(model);

            if (!prise.isEmpty()) {
                prise=prise.replaceAll("[\\s]{1,}", "").toLowerCase().trim();
                if (prise.matches("[-+]?\\d+")) {
                    car.setPrise(new Integer(prise));
                }
                else car.setPrise(0);

            if (!year_prov.isEmpty()) {
                car.setYearMade(new Integer(year_prov));

            if (!engine.isEmpty()) {
                car.setEnginesType(engine);

            if (!gearbox.isEmpty()) {
                car.setTransmission(gearbox);

                if (!comment.isEmpty()){
                    if(comment.length()>380){
                        comment=comment.substring(0,380);
                    }
                    car.setDescription(comment);
                }
                if (!equipment.isEmpty()){
                    if(equipment.length()>20){
                        equipment=equipment.substring(0,20);
                    }
                    car.setEquipment(equipment);}
                if(!region.isEmpty())car.setRegion(region);
                if(!engine_capacity.isEmpty()){car.setEngineCapacity(engine_capacity);}
                else {car.setEngineCapacity(nullMsg);}
                if(!mileage.isEmpty()){
                    mileage=mileage.replaceAll("[\\s]{1,}", "").toLowerCase().trim();
                    if (mileage.matches("[-+]?\\d+")){
                        StringBuffer sb=new StringBuffer(mileage);
                        int step=3;
                        for (int i =0;i<(mileage.length()/3);i++){
                            sb.insert(sb.length() - step, " ");
                            step=step+4;
                        }
                        mileage=sb.toString();
                        mileage=mileage.trim();
                        car.setMileage(mileage);
                    }
                    else {
                        car.setMileage("???");
                    }
                }
                else car.setMileage("0");
             if(!update){
                if (carDAO.setCar(car,idPhotos,session.getId() ) != -1L) {//uploadForm.getFiles()
//                    tempPhotoDAO.deleteDataByIdSession(session.getId());
                    ModelAndView modelAndView=new ModelAndView("my_account");
                    modelAndView.addObject("msg", standartMasege.getMessage(1));
                    dealerDao.updateCountOfCar(car.getIdDealer());
                    return viewHalper.addingDealerAndCarsInView(modelAndView);
                }
             }
                if (update){
                    if (carDAO.updateCarById(car,idPhotos,session.getId())){
//                        tempPhotoDAO.deleteDataByIdSession(session.getId());
                        ModelAndView modelAndView=new ModelAndView("my_account");
                        modelAndView.addObject("msg", standartMasege.getMessage(1));
                        return viewHalper.addingDealerAndCarsInView(modelAndView);
                    }
                }

            }}}}}}

        }

        ModelAndView modelAndView=new ModelAndView("pageForCar");

        modelAndView.addObject("msg", standartMasege.getMessage(2));
        return modelAndView;

    }
    @RequestMapping(value = "*/change_car",method = RequestMethod.GET)
    public ModelAndView responseCar(@ModelAttribute("car")String carId,HttpSession session){
        Car car=carDAO.getCarById(encoderId.decodeID(carId));
        session.setAttribute("chCar", car);
        ModelAndView modelAndView=new ModelAndView("pageForCar");
        return modelAndView;
    }
    @RequestMapping(value = "*/delete_car",method = RequestMethod.GET)
    public ModelAndView deleteCar(@ModelAttribute("car")String car){
        ModelAndView modelAndView=new ModelAndView("my_account");
        if(carDAO.deleteCarById(encoderId.decodeID(car))){
            modelAndView.addObject("msg",standartMasege.getMessage(20));
            return viewHalper.addingDealerAndCarsInView(modelAndView);
        }
        else {
            modelAndView.addObject("msg",standartMasege.getMessage(21));
            return viewHalper.addingDealerAndCarsInView(modelAndView);
        }
    }
    @RequestMapping(value = "*/change_car",method = RequestMethod.POST)
    public ModelAndView changeCar(@ModelAttribute("car")String car){
        Car car1=carDAO.getCarById(encoderId.decodeID(car));
        ModelAndView modelAndView=new ModelAndView("pageForCar");
        modelAndView.addObject("car",car);
        return modelAndView;
    }


}
