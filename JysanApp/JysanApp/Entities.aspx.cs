using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace JysanApp
{
    public partial class Entities : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=(local)\SQLEXPRESS;Initial Catalog=JYSAN;Integrated Security=true;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        public void Clear()
        {
            hfEntityID.Value = "";
            txtBin.Text = txtName.Text = txtCreatedBy.Text = "";
            lblSuccessMessage.Text = lblErrorMessage.Text = "";
            btnSave.Text = "Save";
            btnDelete.Enabled = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("EntityCreateOrUpdate", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@EntityID", hfEntityID.Value == "" ? 0 : Convert.ToInt32(hfEntityID.Value));
            sqlCmd.Parameters.AddWithValue("@Bin", txtBin.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@CreatedBy", txtCreatedBy.Text.Trim());
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            string contactID = hfEntityID.Value;
            Clear();
            if (contactID == "")
                lblSuccessMessage.Text = "Saved successfully";
            else
                lblSuccessMessage.Text = "Updated successfully";
            FillGridView();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("EntityDeleteById", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@EntityID", Convert.ToInt32(hfEntityID.Value));
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            Clear();
            FillGridView();
            lblSuccessMessage.Text = "Deleted successfully";
        }

        protected void contacts_OnClick(object sender, EventArgs e)
        {
            int entityID = Convert.ToInt32((sender as LinkButton).CommandArgument);
            outputEntity.Text = entityID.ToString();
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("ViewContactsOfEntity", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("EntityID", entityID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            gvContacts.DataSource = dtbl;
            gvContacts.DataBind();
        }

        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int entityID = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("EntityViewById", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("EntityID", entityID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfEntityID.Value = entityID.ToString();
            txtBin.Text = dtbl.Rows[0]["Bin"].ToString();
            txtName.Text = dtbl.Rows[0]["Name"].ToString();
            txtCreatedBy.Text = dtbl.Rows[0]["CreatedBy"].ToString();
            btnSave.Text = "Update";
            btnDelete.Enabled = true;
        }

        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("EntityViewAll", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            gvEntity.DataSource = dtbl;
            gvEntity.DataBind();
        }
    }
}