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
        string folio;
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
    DatSolicitud[] solicitudes;
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
    function nuevaSolicitud( string memory folio, string memory descripcion, string memory unidad, string memory programa, string memory beneficiario) public {
        require(compUsuario(msg.sender) == true);
        DatEstado memory datestado = DatEstado(estados[0], "Nueva solicitud generada", "fecha", false, Usuarios[msg.sender].nombre);
        DatSolicitud memory solic = DatSolicitud(folio, descripcion, datestado, unidad, programa, beneficiario, Usuarios[msg.sender].nombre );
        solicitudes.push(solic);
    }

    // ver solicitudes registradas
     function verSolicitudes( string memory folio) public view returns(string memory) {
         DatSolicitud memory solic;
         bool band;
         string memory mensaje;
         for (uint i=0; i < solicitudes.length; i++) {
             if (keccak256(abi.encodePacked(solicitudes[i].folio)) == keccak256(abi.encodePacked(folio))) {
                 solic = solicitudes[i];
                 band = true;
                 break;
             }
         }
         if (band == true)
         {
             mensaje = string(abi.encodePacked("Folio: ",solic.folio," Descripcion: ",solic.descripcion, " Estado: ", solic.estado.estado, " Unidad: ", solic.unidad,
         " Programa: ", solic.programa, " Beneficiario: ", solic.beneficiario, " Generada por: ", solic.generada_por));
         }
         else {
             mensaje = "El folio ingresado no coindide con ninguna solicitud registrada";
         }
         return mensaje;
     }

    // cambiar estado e informacion de solicitud de compra
}