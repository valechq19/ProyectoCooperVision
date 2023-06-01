using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CooperVisionPF.Entities
{

    public class PositionsEnt
    {
        public long ConsecutivoPosition { get; set; }
        public string PositionPru { get; set; }

        public string Access { get; set; }

        public string Application { get; set; }

        public string Level { get; set; }
    }
}