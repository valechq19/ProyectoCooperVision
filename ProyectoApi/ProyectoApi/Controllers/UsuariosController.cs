using ProyectoApi.Entities;
using ProyectoApi.Models;
using System.Collections.Generic;
using System.ComponentModel;
using System.Web.Http;

namespace ProyectoApi.Controllers
{
    public class UsuariosController : ApiController
    {
        UsuariosModel model = new UsuariosModel();

        [HttpGet]
        [AllowAnonymous]
        [Route("api/ConsultarPositions")]
        public List<PositionsEnt> ConsultarPositions()
        {
            return model.ConsultarPositions();
        }



    }
}
