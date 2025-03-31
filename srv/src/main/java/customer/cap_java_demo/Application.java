package customer.cap_java_demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.sap.cds.reflect.CdsModel;
import com.sap.cds.reflect.CdsEntity;
import com.sap.cds.reflect.CdsElement;
import org.springframework.beans.factory.annotation.Autowired;

import jakarta.annotation.PostConstruct;

@SpringBootApplication
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Autowired
	CdsModel model;

	@PostConstruct
	public void inspectModel() {
		if (model == null) {
			System.out.println("[ERROR] CDS 모델이 아직 로딩되지 않았습니다.");
			return;
		}

//		try {
//			CdsEntity product = model.getEntity("com.dkbmc.demo.sf_product");
//			if (product == null) {
//				System.out.println("[WARN] com.dkbmc.demo.sf_product 엔터티를 찾을 수 없습니다.");
//				return;
//			}
//			product.elements().forEach(e -> System.out.println("필드명: " + e.getName()));
//		} catch (Exception e) {
//			System.out.println("[ERROR] CDS 모델 조회 중 예외 발생: " + e.getMessage());
//		}
	}
}
