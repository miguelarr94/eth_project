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
    // arreglo de id de usuarios
    address[] ids;
    // arreglo de solicitudes
    //DatSolicitud[] solicitudes;
    //  Correspondencia identificador (address) del usuario
    mapping(address => DatUsuario) public Usuarios;

// eventos
    // usuario registrado
    event RegUsuario(address indexed idusuario, string nombre, string cargo);

    
// constructor
    constructor() public {
        sysadmin = msg.sender;
        estados = ["Solicitud generada", "Solicitud autorizada", "Solicitud cotizada", "Recibo de cotizaciones de proveedores", "Adjudicada a proveedor", "Orden de compra generada", "Recibo del producto y factura", "Pago efectuado", "Orden de compra finiquitada"];
    }

// metodos

    //registrar los datos de los usuarios Administrativos y SysAdmin
    function regId(address idusuario, string memory nombre, string memory cargo) public {
        require(msg.sender == sysadmin);
        Usuarios[idusuario] = DatUsuario(nombre, cargo); // Agregar usuario al mapping Usuarios
        ids.push(idusuario);

        emit RegUsuario(idusuario, nombre, cargo); // evento de registro de usuario
    }

    // ver susarios registrados
    function verUsuarios(address idusuario) public view returns(string memory) {
        require(msg.sender == sysadmin);
        DatUsuario memory datusuario = Usuarios[idusuario];
        string memory nombre = datusuario.nombre;
        string memory cargo = datusuario.cargo;
        return string(abi.encodePacked("Nombre: ",nombre," Cargo: ",cargo));
    }

    // comprobar usuario registrado
    function compUsuario(address idusuario) internal view returns(bool) {
        bool band;
        for(uint i = 0; i < ids.length; i++) {
            if(idusuario == ids[i]) {
                band = true;
                break;
            }
        }
        return band;
    }

    // dar de alta solicitud de compra
    function nuevaSolicitud() public view returns(string memory) {
        require(compUsuario(msg.sender) == true);
        return "Comprobacion correcta";
    }

    // cambiar estado e informacion de solicitud de compra
}