package dao;

import entity.*;
import util.DBConnUtil;
import exception.*;

import java.sql.*;
import java.util.*;

public class CareerHubDAOImpl implements CareerHubDAO {
    Connection conn = DBConnUtil.getDbConnection();

    public void insertCompany(Company company) {
        try (PreparedStatement ps = conn.prepareStatement("INSERT INTO Companies VALUES (?, ?, ?)")) {
            ps.setInt(1, company.getCompanyID());
            ps.setString(2, company.getCompanyName());
            ps.setString(3, company.getLocation());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DBConnectionException("Error inserting company", e);
        }
    }

    public void insertJobListing(JobListing job) {
        try (PreparedStatement ps = conn.prepareStatement("INSERT INTO Jobs VALUES (?, ?, ?, ?, ?, ?, ?, ?)");) {
            ps.setInt(1, job.getJobID());
            ps.setInt(2, job.getCompanyID());
            ps.setString(3, job.getJobTitle());
            ps.setString(4, job.getJobDescription());
            ps.setString(5, job.getJobLocation());
            ps.setDouble(6, job.getSalary());
            ps.setString(7, job.getJobType());
            ps.setTimestamp(8, Timestamp.valueOf(job.getPostedDate()));
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DBConnectionException("Error inserting job listing", e);
        }
    }

    public void insertApplicant(Applicant applicant) {
        try (PreparedStatement ps = conn.prepareStatement("INSERT INTO Applicants VALUES (?, ?, ?, ?, ?, ?)");) {
            ps.setInt(1, applicant.getApplicantID());
            ps.setString(2, applicant.getFirstName());
            ps.setString(3, applicant.getLastName());
            ps.setString(4, applicant.getEmail());
            ps.setString(5, applicant.getPhone());
            ps.setString(6, applicant.getResume());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DBConnectionException("Error inserting applicant", e);
        }
    }

    public void insertJobApplication(JobApplication application) {
        try (PreparedStatement ps = conn.prepareStatement("INSERT INTO Applications VALUES (?, ?, ?, ?, ?)");) {
            ps.setInt(1, application.getApplicationID());
            ps.setInt(2, application.getJobID());
            ps.setInt(3, application.getApplicantID());
            ps.setTimestamp(4, Timestamp.valueOf(application.getApplicationDate()));
            ps.setString(5, application.getCoverLetter());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DBConnectionException("Error inserting application", e);
        }
    }

    public List<JobListing> getJobListings() {
        List<JobListing> jobs = new ArrayList<>();
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM Jobs")) {
            while (rs.next()) {
                JobListing job = new JobListing(
                        rs.getInt("JobID"),
                        rs.getInt("CompanyID"),
                        rs.getString("JobTitle"),
                        rs.getString("JobDescription"),
                        rs.getString("JobLocation"),
                        rs.getDouble("Salary"),
                        rs.getString("JobType"),
                        rs.getTimestamp("PostedDate").toLocalDateTime()
                );
                jobs.add(job);
            }
        } catch (SQLException e) {
            throw new DBConnectionException("Error retrieving job listings", e);
        }
        return jobs;
    }

    public List<JobListing> searchJobsBySalaryRange(double minSalary, double maxSalary) {
        List<JobListing> jobs = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM Jobs WHERE Salary BETWEEN ? AND ?")) {
            ps.setDouble(1, minSalary);
            ps.setDouble(2, maxSalary);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobListing job = new JobListing(
                        rs.getInt("JobID"),
                        rs.getInt("CompanyID"),
                        rs.getString("JobTitle"),
                        rs.getString("JobDescription"),
                        rs.getString("JobLocation"),
                        rs.getDouble("Salary"),
                        rs.getString("JobType"),
                        rs.getTimestamp("PostedDate").toLocalDateTime()
                );
                jobs.add(job);
            }
        } catch (SQLException e) {
            throw new DBConnectionException("Error searching job by salary range", e);
        }
        return jobs;
    }



    public List<Applicant> getApplicants() {
    	
        List<Applicant> apps = new ArrayList<>();
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM applicants")) {
            while (rs.next()) {
                Applicant app = new Applicant(
                        rs.getInt("ApplicantID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("Resume")
              
                );
               apps.add(app);
            }
        } catch (SQLException e) {
            throw new DBConnectionException("Error retrieving job listings", e);
        }
       
    
        return apps;
    }


}

