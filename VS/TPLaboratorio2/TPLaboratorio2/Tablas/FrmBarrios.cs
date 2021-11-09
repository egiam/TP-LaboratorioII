using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmBarrios : Form
    {
        ConeccionEntreForms conex;

        public FrmBarrios()
        {
            InitializeComponent();
            conex = new ConeccionEntreForms();
        }

        private void FrmBarrios_Load(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(45, 66, 91);
            conex.AlternarColorGRD(grdBarrios);
            string select = "select cod_barrio, barrio, localidad from localidades l join barrios b on b.cod_localidad = l.cod_localidad";
            grdBarrios.DataSource = conex.Coneccion(select);
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
