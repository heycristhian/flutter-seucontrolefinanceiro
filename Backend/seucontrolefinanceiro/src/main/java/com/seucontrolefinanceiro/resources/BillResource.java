package com.seucontrolefinanceiro.resources;

import com.seucontrolefinanceiro.dto.BillDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("scf-service/bills")
public class BillResource {

    public ResponseEntity<BillDTO> find(String query) {
        return null;
    }
}
