using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JysanApp
{
    public partial class People : System.Web.UI.Page
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
            hfPersonID.Value = "";
            txtIin.Text = txtFirstName.Text = txtMiddleName.Text = txtLastName.Text = txtCreatedBy.Text = txtEntityID.Text = "";
            lblSuccessMessage.Text = lblErrorMessage.Text = "";
            btnSave.Text = "Save";
            btnDelete.Enabled = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("PersonCreateOrUpdate", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@PersonID", hfPersonID.Value==""?0:Convert.ToInt32(hfPersonID.Value));
            sqlCmd.Parameters.AddWithValue("@Iin", txtIin.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@MiddleName", txtMiddleName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@EntityID", txtEntityID.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@CreatedBy", txtCreatedBy.Text.Trim());
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            string contactID = hfPersonID.Value;
            Clear();
            if (contactID == "")
                lblSuccessMessage.Text = "Saved successfully";
            else
                lblSuccessMessage.Text = "Updated successfully";
            FillGridView();
        }

        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("PeopleViewAll", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            gvPerson.DataSource = dtbl;
            gvPerson.DataBind();
        }
        // OnSelectedIndexChanged="gvPerson_SelectedIndexChanged"
        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int personID = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("PersonViewById", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("PersonID", personID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfPersonID.Value = personID.ToString();
            txtIin.Text = dtbl.Rows[0]["Iin"].ToString();
            txtFirstName.Text = dtbl.Rows[0]["FirstName"].ToString();
            txtMiddleName.Text = dtbl.Rows[0]["MiddleName"].ToString();
            txtLastName.Text = dtbl.Rows[0]["LastName"].ToString();
            txtEntityID.Text = dtbl.Rows[0]["EntityID"].ToString();
            txtCreatedBy.Text = dtbl.Rows[0]["CreatedBy"].ToString();
            btnSave.Text = "Update";
            btnDelete.Enabled = true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("PersonDeleteById", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@PersonId", Convert.ToInt32(hfPersonID.Value));
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            Clear();
            FillGridView();
            lblSuccessMessage.Text = "Deleted successfully";
        }
    }
}