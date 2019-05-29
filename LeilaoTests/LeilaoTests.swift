//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeveReceberUmLance(){
        
        let leilao = Leilao(descricao: "MacBook Pro 15")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let steveJobs = Usuario(nome: "steveJobs")
        leilao.propoe(lance: Lance(steveJobs, 2000.0))
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
        
    }
    
    func testDeveReceberVariosLances(){
        let leilao = Leilao(descricao: "MacBook Pro 15")
        let steveJobs = Usuario(nome: "steveJobs")
        leilao.propoe(lance: Lance(steveJobs, 2000.0))
        let billGates = Usuario(nome: "billGates")
        leilao.propoe(lance: Lance(billGates, 1700.0))
        
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
        XCTAssertEqual(1700.0, leilao.lances?[1].valor)
        
    }
    
    func testDeveIgnorarDoisLancesSeguidosDoMesmoUsuario(){
        let leilao = Leilao(descricao: "MacBook Pro 15")
        let steveJobs = Usuario(nome: "steveJobs")
        leilao.propoe(lance: Lance(steveJobs, 2000.0))
        leilao.propoe(lance: Lance(steveJobs, 2300.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
    }
    
    
    
}
