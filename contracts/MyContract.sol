pragma solidity 0.6.12;

// Smart Contract para el seguimiento de solicitudes de compra.
contract MyContract {

    // variables
    address payable public sysadmin;
    // datos de los usuarios
    struct DatUsuario {
        string nombre;
        string cargo;
    }
    // datos de las solicitudes
    struct DatSolicitud {
        uint folio;
        string descripcion;
        DatEstado estado;
        string unidad;
        string programa;
        string beneficiario;
        string generada_por;
    }
    // estados de las solicitudes
    struct DatEstado{
        string estado;
        string nota;
        string fecha;
        bool correccion;
        string n_usuario;
    }
    // posibles estados de las solicitudes
    string[] public estados;
    //  Correspondencia identificador (address) del usuario
    mapping(address => DatUsuario) public Usuarios;
    
    // constructor

    // metodos

}