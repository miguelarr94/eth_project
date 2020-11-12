pragma solidity 0.6.12;

// Smart Contract para el seguimiento de solicitudes de compra.
contract MyContract {

    // variables
    address payable public admin;
    // datos de los usuarios
    struct DatUsuario {
        string nombre;
        string cargo;
    }
    // datos de las solicitudes
    struct DatSolicitud {
        string id;
        string descripcion;
        string estado;
    }
    //  Correspondencia identificador (address) del usuario
    mapping(address => DatUsuario) public usuarios;
    
    // constructor

    // metodos

}