using ProyectoApi.Entities;
using ProyectoApi.ModeloBD;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoApi.Models
{
    public class UsuariosModel
    {

        public List<PositionsEnt> ConsultarPositions()
        {
            using (var conexion = new AccessRequestsEntities())


            {
                List<PositionsEnt> respuesta = new List<PositionsEnt>();
                var datosBD = conexion.ConsultarPositions().ToList();

                if (datosBD.Count > 0)
                {
                    foreach (var item in datosBD)
                    {
                        respuesta.Add(new PositionsEnt
                        {
                            Access = item.Access,
                            Application = item.Application,
                            Level = item.Level,
                            
                        });
                    }
                }

                return respuesta;
            }
        }
    }

    }




