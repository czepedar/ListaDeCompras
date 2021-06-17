//
//  ViewController.swift
//  ListaDeCompras
//
//  Created by user198873 on 8/6/21.
//

import UIKit

class ViewController: UIViewController {

    

    @IBOutlet weak var textoTitulo: UITextField!
    @IBOutlet weak var textoLista: UITextField!
    @IBOutlet weak var textoDescrip: UITextField!
    @IBOutlet weak var tablaDeLista: UITableView!
    @IBOutlet weak var imagen: UIImageView!
    
    //var listaCompras:[String]?
    //Prueba cambio en GitHup
    var listaCompras:[Articulo]? {
        didSet{
            self.tablaDeLista.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //se inicializa el array
        listaCompras = [Articulo]()

    }
    	
    //función para odenar la lista de compras
    /*func odenar(flag:Bool)-> [String]{
    if let listaSortedAlfa = self.listaCompras {
        //let alfaList = listaSortedAlfa.sorted()
            return alfaList
        }
        return[]
    }*/

    @IBAction func guardaLista(_ sender: Any) {
        
        let listaCompra = Articulo(lista: textoTitulo.text!, nombre: textoLista.text!, descripcion: textoDescrip.text!,comprado: false, imagenV: imagen.image! )
        
        self.listaCompras?.append(listaCompra)
        print(self.listaCompras)
          }
    
    
    
/*@IBAction func ordenarLista(_ sender: Any) {
       
        
       self.listaCompras = odenar (flag: true)
        print(self.listaCompras)
        self.tablaDeLista.reloadData()
    }

}*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = self.tablaDeLista.indexPathForSelectedRow{
            if let listaCompra = self.listaCompras?[index.row]{
                let destino = segue.destination as? DetailViewController
                destino?.articuloSeleccionado = listaCompra
                destino?.delegate = self
            }
        }
    }
    

    @IBAction func esconderTeclado(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    @IBAction func cargaFoto(_ sender: Any) {
        let cargarFot = UIImagePickerController()
        cargarFot.sourceType = .photoLibrary
        cargarFot.delegate = self
        cargarFot.allowsEditing = true
        present(cargarFot, animated: true)
    }
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listacompras = self.listaCompras else {
            return 0
        }
        return listacompras.count
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contexItem = UIContextualAction(style: .destructive, title: "Eliminar"){(action, view, bool) in
             //codigo Elminar
            self.listaCompras?.remove(at: indexPath.row)
            self.tablaDeLista.reloadData()
           
           
        }
        
        let contexItemTwo = UIContextualAction(style: .normal, title: "Editar"){(action, view, bool) in
          //codigo Modificar
        }
        
        let swipAction = UISwipeActionsConfiguration(actions: [contexItemTwo,contexItem])
        
        return swipAction
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellList = tableView.dequeueReusableCell(withIdentifier:  "cell", for: indexPath)
          if let listacompras = self.listaCompras {
            cellList.textLabel?.text = listacompras[indexPath.row].nombre
    }
        return cellList
   }
}



extension ViewController:ArticuloDelegate {
    
    func actualizarArticulo(listaCompra: Articulo?) {
        print(listaCompra)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageV = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imagen.image = imageV
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



