//
//  DitailViewController.swift
//  ListaDeCompras
//
//  Created by user198873 on 11/6/21.
//

import UIKit

class DetailViewController: UIViewController {

    
    
   
    @IBOutlet weak var textoTituloProdu: UILabel!
    @IBOutlet weak var textoNombreProdu: UILabel!
    @IBOutlet weak var textoDescrpProdu: UILabel!
    @IBOutlet weak var imagenDetail: UIImageView!
    
    var articuloSeleccionado:Articulo?
    var delegate:ArticuloDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textoTituloProdu.text = articuloSeleccionado?.lista
        textoNombreProdu.text = articuloSeleccionado?.nombre
        textoDescrpProdu.text = articuloSeleccionado?.descripcion
        imagenDetail.image = articuloSeleccionado?.imagenV as? UIImage
    }
    
    @IBAction func comprado(_ sender: Any) {
        articuloSeleccionado?.comprado = true
        self.delegate?.actualizarArticulo(listaCompra: articuloSeleccionado)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
