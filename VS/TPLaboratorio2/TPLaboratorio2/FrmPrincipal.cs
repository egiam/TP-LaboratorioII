using System;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using TPLaboratorio2;
using TPLaboratorio2.Tablas;

namespace ModernGUI_V3
{
    public partial class FormPrincipal : Form
    {
        public FormPrincipal()
        {
            InitializeComponent();
            CustomizeDesign();
        }

        private void FormPrincipal_Load(object sender, EventArgs e)
        {
            btnMaximizar.Enabled = false;
            btnRestaurar.Enabled = false;
        }

        private void CustomizeDesign()
        {
            panelSubConsultas.Visible = false;
            panelSubTabla1.Visible = false;
            panelSubTabla2.Visible = false;
        }

        private void HideSubMenu()
        {
            if (panelSubConsultas.Visible == true)
                panelSubConsultas.Visible = false;
            if (panelSubTabla1.Visible == true)
                panelSubTabla1.Visible = false;
            if (panelSubTabla2.Visible == true)
                panelSubTabla2.Visible = false;
            txtConsultas.BackColor = Color.FromArgb(4, 41, 68);
            btnTablas.BackColor = Color.FromArgb(4, 41, 68);
        }

        private void ShowSubMenu(Panel subMenu)
        {
            if (subMenu.Visible == false)
            {
                HideSubMenu();
                subMenu.Visible = true;
            }
            else
                subMenu.Visible = false;
        }

        #region Funcionalidades del formulario
        //RESIZE METODO PARA REDIMENCIONAR/CAMBIAR TAMAÑO A FORMULARIO EN TIEMPO DE EJECUCION ----------------------------------------------------------
        private int tolerance = 12;
        private const int WM_NCHITTEST = 132;
        private const int HTBOTTOMRIGHT = 17;
        private Rectangle sizeGripRectangle;

        protected override void WndProc(ref Message m)
        {
            switch (m.Msg)
            {
                case WM_NCHITTEST:
                    base.WndProc(ref m);
                    var hitPoint = this.PointToClient(new Point(m.LParam.ToInt32() & 0xffff, m.LParam.ToInt32() >> 16));
                    if (sizeGripRectangle.Contains(hitPoint))
                        m.Result = new IntPtr(HTBOTTOMRIGHT);
                    break;
                default:
                    base.WndProc(ref m);
                    break;
            }
        }
        //----------------DIBUJAR RECTANGULO / EXCLUIR ESQUINA PANEL 
        protected override void OnSizeChanged(EventArgs e)
        {
            base.OnSizeChanged(e);
            var region = new Region(new Rectangle(0, 0, this.ClientRectangle.Width, this.ClientRectangle.Height));

            sizeGripRectangle = new Rectangle(this.ClientRectangle.Width - tolerance, this.ClientRectangle.Height - tolerance, tolerance, tolerance);

            region.Exclude(sizeGripRectangle);
            this.panelContenedor.Region = region;
            this.Invalidate();
        }
        //----------------COLOR Y GRIP DE RECTANGULO INFERIOR
        protected override void OnPaint(PaintEventArgs e)
        {
            SolidBrush blueBrush = new SolidBrush(Color.FromArgb(244, 244, 244));
            e.Graphics.FillRectangle(blueBrush, sizeGripRectangle);

            base.OnPaint(e);
            ControlPaint.DrawSizeGrip(e.Graphics, Color.Transparent, sizeGripRectangle);
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
        //Capturar posicion y tamaño antes de maximizar para restaurar
        int lx, ly;
        int sw, sh;
        private void btnMaximizar_Click(object sender, EventArgs e)
        {
            lx = this.Location.X;
            ly = this.Location.Y;
            sw = this.Size.Width;
            sh = this.Size.Height;
            btnMaximizar.Visible = false;
            btnRestaurar.Visible = true;
            this.Size = Screen.PrimaryScreen.WorkingArea.Size;
            this.Location = Screen.PrimaryScreen.WorkingArea.Location;
        }

        private void btnRestaurar_Click(object sender, EventArgs e)
        {
            btnMaximizar.Visible = true;
            btnRestaurar.Visible = false;
            this.Size = new Size(sw, sh);
            this.Location = new Point(lx, ly);
        }

        private void panelBarraTitulo_MouseMove(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(this.Handle, 0x112, 0xf012, 0);
        }

        private void btnMinimizar_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        //METODO PARA ARRASTRAR EL FORMULARIO---------------------------------------------------------------------
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();

        //private void button1_Click(object sender, EventArgs e)
        //{
        //    AbrirFormulario<Form1>();
        //    button1.BackColor = Color.FromArgb(12, 61, 92);
        //}

        //private void button2_Click(object sender, EventArgs e)
        //{
        //    AbrirFormulario<Form2>();
        //    button2.BackColor = Color.FromArgb(12, 61, 92);
        //}

        //private void button3_Click(object sender, EventArgs e)
        //{
        //    AbrirFormulario<Form3>();
        //    button3.BackColor = Color.FromArgb(12, 61, 92);
        //}

        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hWnd, int wMsg, int wParam, int lParam);

        private void panelMenu_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void txtConsultas_Click(object sender, EventArgs e)
        {
            ShowSubMenu(panelSubConsultas);
            if (panelSubConsultas.Visible == true)
                txtConsultas.BackColor = Color.FromArgb(22, 71, 102);
            else
                txtConsultas.BackColor = Color.FromArgb(4, 41, 68);
        }

        private void btnTablas_Click(object sender, EventArgs e)
        {
            if (panelSubTabla2.Visible == true)
                panelSubTabla2.Visible = false;
            else
                ShowSubMenu(panelSubTabla1);

            if (panelSubTabla1.Visible == true || panelSubTabla2.Visible == true)
                btnTablas.BackColor = Color.FromArgb(22, 71, 102);
            else
                btnTablas.BackColor = Color.FromArgb(4, 41, 68);
        }

        private void btnSiguiente_Click(object sender, EventArgs e)
        {
            ShowSubMenu(panelSubTabla2);
            if (panelSubTabla1.Visible == true || panelSubTabla2.Visible == true)
                btnTablas.BackColor = Color.FromArgb(22, 71, 102);
            else
                btnTablas.BackColor = Color.FromArgb(4, 41, 68);
        }

        private void btnVolver_Click(object sender, EventArgs e)
        {
            ShowSubMenu(panelSubTabla1);
            if (panelSubTabla1.Visible == true || panelSubTabla2.Visible == true)
                btnTablas.BackColor = Color.FromArgb(22, 71, 102);
            else
                btnTablas.BackColor = Color.FromArgb(4, 41, 68);
        }

        private void btnConsulta1_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmConsulta1>();
            btnConsulta1.BackColor = Color.FromArgb(12, 61, 92);
            HideSubMenu();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmProvincias>();
            //HideSubMenu();
        }

        private void btnConsulta2_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmConsulta2>();
            btnConsulta2.BackColor = Color.FromArgb(12, 61, 92);
            HideSubMenu();
        }

        private void btnConsulta3_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmConsulta3>();
            btnConsulta3.BackColor = Color.FromArgb(12, 61, 92);
            HideSubMenu();
        }

        private void btnConsulta4_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmConsulta4>();
            btnConsulta4.BackColor = Color.FromArgb(12, 61, 92);
            HideSubMenu();
        }

        private void btnLocalidades_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmLocalidades>();
            //HideSubMenu();
        }

        private void btnBarrios_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmBarrios>();
            //HideSubMenu();
        }

        private void panelBarraTitulo_Paint(object sender, PaintEventArgs e)
        {

        }

        private void btnConsulta5_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmConsulta5>();
            btnConsulta5.BackColor = Color.FromArgb(12, 61, 92);
            HideSubMenu();

        }

        private void btnLogistica_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmLogistica>();
            //HideSubMenu();
        }

        private void btnOS_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmObraSocial>();
            //HideSubMenu();
        }

        private void btnPlan_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmPlan>();
            //HideSubMenu();
        }

        private void btnTC_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmTipoContacto>();
            //HideSubMenu();
        }

        private void btnContacto_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmContacto>();
            //HideSubMenu();
        }

        private void btnClientes_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmClientes>();
            //HideSubMenu();
        }

        private void btnEmpleados_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmEmpleados>();
            //HideSubMenu();
        }

        private void btnSucursales_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmSucursales>();
            //HideSubMenu();
        }

        private void btnSexos_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmSexos>();
            //HideSubMenu();
        }

        private void btnMedicos_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmMedicos>();
            //HideSubMenu();
        }

        private void btnTD_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmTipoDoc>();
            //HideSubMenu();
        }

        private void btnES_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmEntregaSum>();
            //HideSubMenu();
        }

        private void btnDE_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmDetalleEntrega>();
            //HideSubMenu();
        }

        private void btnRecetas_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmRecetas>();
            //HideSubMenu();
        }

        private void btnDR_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmDetalleReceta>();
            //HideSubMenu();
        }

        private void btnFacturas_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmFacturas>();
            //HideSubMenu();
        }

        private void btnDF_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmDetalleFactura>();
            //HideSubMenu();
        }

        private void btnSuministros_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmSuministros>();
            //HideSubMenu();
        }

        private void btnTS_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmTipoSuministro>();
            //HideSubMenu();
        }

        private void btnDescuento_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmDescuentos>();
            //HideSubMenu();
        }

        private void btnSS_Click(object sender, EventArgs e)
        {
            AbrirFormulario<FrmSucursalSumin>();
            //HideSubMenu();
        }

        private void panelformularios_Paint(object sender, PaintEventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }


        #endregion
        //METODO PARA ABRIR FORMULARIOS DENTRO DEL PANEL
        private void AbrirFormulario<MiForm>() where MiForm : Form, new()
        {
            Form formulario;
            formulario = panelformularios.Controls.OfType<MiForm>().FirstOrDefault();//Busca en la colecion el formulario
            //si el formulario/instancia no existe
            if (formulario == null)
            {
                formulario = new MiForm();
                formulario.TopLevel = false;
                formulario.FormBorderStyle = FormBorderStyle.None;
                formulario.Dock = DockStyle.Fill;
                panelformularios.Controls.Add(formulario);
                panelformularios.Tag = formulario;
                formulario.Show();
                formulario.BringToFront();
                formulario.FormClosed += new FormClosedEventHandler(CloseForms);
            }
            //si el formulario/instancia existe
            else
            {
                formulario.BringToFront();
            }
        }
        private void CloseForms(object sender, FormClosedEventArgs e)
        {
            if (Application.OpenForms["FrmConsulta1"] == null)
                btnConsulta1.BackColor = Color.FromArgb(39, 39, 69);
            if (Application.OpenForms["FrmConsulta2"] == null)
                btnConsulta2.BackColor = Color.FromArgb(39, 39, 69);
            if (Application.OpenForms["FrmConsulta3"] == null)
                btnConsulta3.BackColor = Color.FromArgb(39, 39, 69);
            if (Application.OpenForms["FrmConsulta4"] == null)
                btnConsulta4.BackColor = Color.FromArgb(39, 39, 69);
            if (Application.OpenForms["FrmConsulta5"] == null)
                btnConsulta5.BackColor = Color.FromArgb(39, 39, 69);
        }
    }
}
