//
//  Splashscreen.swift
//  GitbubAPI
//
//  Created by Adi Wibowo on 24/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class Splashscreen: UIViewController {

    @IBOutlet weak var btnGo: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnGo.rx.tap.do(onNext: {
            let cont = RepoListVC()
            cont.modalPresentationStyle = .fullScreen
            self.present(cont, animated: true, completion: nil)
        })
        .subscribe()
        .disposed(by: disposeBag)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }


}

