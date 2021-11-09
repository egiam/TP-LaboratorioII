using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmEmpleados : Form
    {
        public FrmEmpleados()
        {
            InitializeComponent();
        }

        private void FrmEmpleados_Load(object sender, EventArgs e)
        {
            ConeccionEntreForms conex = new ConeccionEntreForms();
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdPlan);
            string select = "select id_empleado Codigo, e.apellido+', '+e.nombre Empleado, tipo_doc+': '+str(nro_doc) Documento, barrio, e.calle+', '+str(e.nro_calle) Direccion, fecha_nac Nacimiento, el.nombre Logistica "+
                            "from empleados e join tipos_documento td on e.id_tipo_doc = td.id_tipo_doc join barrios b on e.cod_barrio = b.cod_barrio join empresas_logistica el on e.id_empresas_log = el.id_empresas_log";
            grdPlan.DataSource = conex.Coneccion(select);
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
