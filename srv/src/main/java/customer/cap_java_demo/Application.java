package customer.cap_java_demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.beans.factory.annotation.Autowired;

import com.sap.cds.reflect.CdsModel;
import com.sap.cds.reflect.CdsEntity;

import jakarta.annotation.PostConstruct;
import java.util.Optional;

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
			System.err.println("[ERROR] CDS 모델이 아직 로딩되지 않았습니다.");
			return;
		}

		System.out.println("[INFO] 로드된 CDS 엔터티 목록:");
		model.entities().forEach(entity -> System.out.println(" - " + entity.getName()));

		String targetEntity = "com.dkbmc.demo.sf_product";
		Optional<CdsEntity> productOpt = model.findEntity(targetEntity);

		if (productOpt.isPresent()) {
			System.out.printf("[INFO] 엔터티 '%s' 의 필드 목록:%n", targetEntity);
			productOpt.get().elements().forEach(e -> System.out.println(" - 필드명: " + e.getName()));
		} else {
			System.err.printf("[WARN] 엔터티 '%s' 를 찾을 수 없습니다.%n", targetEntity);
		}
	}
}
