package dao;

import java.util.List;
import entity.*;

public interface CareerHubDAO {
    void insertCompany(Company company);
    void insertJobListing(JobListing job);
    void insertApplicant(Applicant applicant);
    void insertJobApplication(JobApplication application);
    List<JobListing> getJobListings();
   
    List<Applicant> getApplicants();

    List<JobListing> searchJobsBySalaryRange(double minSalary, double maxSalary);
}