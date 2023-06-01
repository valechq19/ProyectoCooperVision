
using CooperVisionPF.Entities;
using CooperVisionPF.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace CooperVisionPF.Controllers
{

    public class UsuariosController : Controller
    {
        UsuariosModel model = new UsuariosModel();
        [HttpGet]
        public ActionResult ConsultarPositions()
        {
            var resultado = model.ConsultarPositions();
            return View(resultado);
        }



    }
}



