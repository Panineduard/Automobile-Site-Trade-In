package interfaceModel.dao;

import com.modelClass.Dealer;
import com.modelClass.KeyHolder;

import java.util.List;

/**
 * Created by volkswagen1 on 05.05.2016.
 */
public interface DealerDaoInterface {
    public KeyHolder getKeyDHolderByKeyAndDeleteKey(String key);
    public boolean checkIdDealerByEmail(String email,String idDealer);
    public Dealer getDealerById(String id);
    public List<Dealer> getIdDealersWithoutAuth();
}
