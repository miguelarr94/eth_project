// SPDX-License-Identifier: MIT
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
        string nom_usuario;
    }
    // posibles estados de las solicitudes
    string[] public estados;
    // arreglo de usuarios
    DatUsuario[] usuarios;
    // arreglo de usuarios
    DatSolicitud[] solicitudes;
    //  Correspondencia identificador (address) del usuario
    mapping(address => DatUsuario) public Usuarios;
    
// constructor
    constructor() public {
        sysadmin = msg.sender;
        estados = ["Solicitud generada", "Solicitud autorizada", "Solicitud cotizada", "Recibo de cotizaciones de proveedores", "Adjudicada a proveedor", "Orden de compra generada", "Recibo del producto y factura", "Pago efectuado", "Orden de compra finiquitada"];
        usuarios.push(DatUsuario('Juan', 'SysAdmin'));
        usuarios.push(DatUsuario('Pedro', 'Administrador de FCAyS'));
    }

// metodos

    //registrar la direccion Ethereum (id) de los usuarios


}