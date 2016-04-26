package interfaceModel.dao;

import com.helpers.ResultCars;
import com.helpers.SearchOptions;
import com.modelClass.Car;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashSet;
import java.util.List;

/**
 * Created by volkswagen1 on 13.03.2016.
 */
public interface CarDaoInterface {
    public boolean deletePhotoByCarsId(long idCar,long numberOfPhoto);
    public List<Car> getCarByIdDealer(String idD);
    public Long setCar(Car car,List<MultipartFile> multipartFiles);
    //this method found cars for all or one parameters if prise 1 it is ascending_price if prise 2 by_prices_descending 0 nothing
    public ResultCars getCarsByParameters(SearchOptions options, int page);
    public List<Car> getLastCars(Integer countLastCar);
    public Car getCarById(String id);
    public boolean deleteCarById(String idCar);
    public boolean updateCarById(Car car,List<MultipartFile> multipartFiles);
    public HashSet<String> getOldCarOwnersEmails(Integer period_in_month);
    public boolean deleteOldCar(Integer period_in_month);
    public  void updateDateProvideDyId(Long id);
    public void  deleteCarsByDealersID(String idDealer);
    public List<String>getModelByBrand(String brand);

}
