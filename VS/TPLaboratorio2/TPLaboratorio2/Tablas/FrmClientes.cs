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
    public partial class FrmClientes : Form
    {
        public FrmClientes()
        {
            InitializeComponent();
        }

        private void FrmClientes_Load(object sender, EventArgs e)
        {
            ConeccionEntreForms conex = new ConeccionEntreForms();
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdPlan);
            string select = "select	id_cliente Codigo, apellido + ', ' + c.nombre Cliente, tipo_doc + ': ' + str(nro_doc) Documento, barrio, calle + ', ' + str(nro_calle) Direccion, nro_afiliado, p.nombre + ' - ' + os.nombre, fecha_nac Nacimiento, s.tipo " +
                            " from clientes c join tipos_documento td on c.id_tipo_doc = td.id_tipo_doc join barrios b on c.cod_barrio = b.cod_barrio "+
                                   "join planes p on c.id_plan = p.id_plan join obras_sociales os on p.id_obra_social = os.id_obra_social join Sexos s on c.id_tipo_sexo = s.id_tipo_sexo";
            grdPlan.DataSource = conex.Coneccion(select);
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnCerrar_Click_1(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
