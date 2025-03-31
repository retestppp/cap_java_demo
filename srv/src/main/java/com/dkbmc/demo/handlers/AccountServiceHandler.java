package com.dkbmc.demo.handlers;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.cds.CdsReadEventContext;

import org.springframework.stereotype.Component;

@Component
@ServiceName("AccountService") // schema.cds에서 정의한 서비스 이름
public class AccountServiceHandler implements EventHandler {

    @On(event = "READ", entity = "sf_product") // 문자열로 직접 지정
    public void onReadProducts(CdsReadEventContext context) {
        System.out.println(">>> sf_product READ 요청 발생!");

        // 여기서 context.getCqn(), context.setResult(...) 등 사용 가능
    }
}
