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
    public partial class FrmSuministros : Form
    {
        public FrmSuministros()
        {
            InitializeComponent();
        }

        private void FrmSuministros_Load(object sender, EventArgs e)
        {
            ConeccionEntreForms conex = new ConeccionEntreForms();
            BackColor = Color.FromArgb(45, 66, 91);
            label3.ForeColor = Color.White;
            conex.AlternarColorGRD(grdPlan);
            string select = "select codigo_barra Codigo, s.Nombre, Descripcion, venta_libre, Precio, tipo, stock_minimo 'Stock Minimo', Stock from suministros s join tipos_suministro ts on s.id_tipo_suministro = ts.id_tipo_suministro";
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

        private void grdPlan_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (this.grdPlan.Columns[e.ColumnIndex].Name == "Stock")
            {
                if (e.Value != null)
                {
                    if (e.Value.GetType() != typeof(System.DBNull))
                    {
                        //Stock menor a 30
                        if (Convert.ToInt32(e.Value) <= 30)
                        {
                            //e.CellStyle.BackColor = Color.LightSalmon;
                            e.CellStyle.ForeColor = Color.Yellow;
                        }
                        //Stock menor a 20
                        if (Convert.ToInt32(e.Value) <= 20)
                        {
                            //e.CellStyle.BackColor = Color.Salmon;
                            e.CellStyle.ForeColor = Color.Red;
                        }
                    }
                }
            }
        }
    }
}
