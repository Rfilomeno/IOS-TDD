//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Rodrigo Filomeno on 28/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import XCTest
@testable import Leilao


class AvaliadorTests: XCTestCase {

    var leiloeiro:Avaliador!
    private var joao:Usuario!
    private var jose:Usuario!
    private var maria:Usuario!
    
    override func setUp() {
        super.setUp()
        leiloeiro = Avaliador()
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeveEntenderLancesEmOrdemCrescente(){
        // Cenario
        
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))
        
        // Acao
        
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
       
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }

    func testDeveEntenderSomenteUmLance(){
        // Cenario
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(joao, 1000.0))
        
        // Acao
        
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaiores(){
        // Cenario
        
//        let leilao = Leilao(descricao: "Playstation 4")
//        leilao.propoe(lance: Lance(maria, 250.0))
//        leilao.propoe(lance: Lance(joao, 300.0))
//        leilao.propoe(lance: Lance(jose, 400.0))
//        leilao.propoe(lance: Lance(maria, 1400.0))
        
        // criado um TestDataBuilder CriadorDeLeilao()
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
                                        .lance(maria, 250.0)
                                        .lance(joao, 300.0)
                                        .lance(jose, 400.0)
                                        .lance(maria, 1400.0)
                                        .constroi()
        // Acao

        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        let lista = leiloeiro.tresMaiores()
        XCTAssertEqual(3, lista.count)
        XCTAssertEqual(1400.0, lista[0].valor)
        XCTAssertEqual(400.0, lista[1].valor)
        XCTAssertEqual(300.0, lista[2].valor)
    }
    
    
    func testDeveIgnorarLeilaoSemNenhumLance(){
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4").constroi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possivel avaliar um leilão sem lances.") { (error) in
            print(error.localizedDescription)
        }
    }
}
