
package main;

import dao.*;
import entity.*;
import java.util.*;
import java.time.LocalDateTime;

public class MainModule {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        CareerHubDAO service = new CareerHubDAOImpl();
        int choice;

        do {
            System.out.println("\n--- CareerHub Job Board ---");
            System.out.println("1. Add Company");
            System.out.println("2. Add Job Listing");
            System.out.println("3. Add Applicant");
            System.out.println("4. Apply for Job");
            System.out.println("5. View Job Listings");
            System.out.println("6. View Applicants");
            System.out.println("7. Search Jobs by Salary Range");
            System.out.println("0. Exit");
            System.out.print("Enter choice: ");
            choice = scanner.nextInt();
            scanner.nextLine(); 

            switch (choice) {
                case 1:
                    System.out.print("Enter Company ID: ");
                    int cid = scanner.nextInt(); scanner.nextLine();
                    System.out.print("Enter Company Name: ");
                    String cname = scanner.nextLine();
                    System.out.print("Enter Location: ");
                    String cloc = scanner.nextLine();
                    Company company = new Company(cid, cname, cloc);
                    service.insertCompany(company);
                    System.out.println("Company added successfully.");
                    break;
                case 2:
                    System.out.print("Enter Job ID: ");
                    int jid = scanner.nextInt(); scanner.nextLine();
                    System.out.print("Enter Company ID: ");
                    int jcID = scanner.nextInt(); scanner.nextLine();
                    System.out.print("Enter Job Title: ");
                    String jtitle = scanner.nextLine();
                    System.out.print("Enter Job Description: ");
                    String jdesc = scanner.nextLine();
                    System.out.print("Enter Job Location: ");
                    String jloc = scanner.nextLine();
                    System.out.print("Enter Salary: ");
                    double jsalary = scanner.nextDouble(); scanner.nextLine();
                    System.out.print("Enter Job Type: ");
                    String jtype = scanner.nextLine();
                    JobListing job = new JobListing(jid, jcID, jtitle, jdesc, jloc, jsalary, jtype, LocalDateTime.now());
                    service.insertJobListing(job);
                    System.out.println("Job listing added successfully.");
                    break;
                case 3:
                    System.out.print("Enter Applicant ID: ");
                    int aid = scanner.nextInt(); scanner.nextLine();
                    System.out.print("Enter First Name: ");
                    String fname = scanner.nextLine();
                    System.out.print("Enter Last Name: ");
                    String lname = scanner.nextLine();
                    System.out.print("Enter Email: ");
                    String email = scanner.nextLine();
                    System.out.print("Enter Phone: ");
                    String phone = scanner.nextLine();
                    System.out.print("Enter Resume Info: ");
                    String resume = scanner.nextLine();
                    Applicant applicant = new Applicant(aid, fname, lname, email, phone, resume);
                    service.insertApplicant(applicant);
                    System.out.println("Applicant profile created.");
                    break;
                case 4:
                    System.out.print("Enter Application ID: ");
                    int appid = scanner.nextInt(); scanner.nextLine();
                    System.out.print("Enter Job ID: ");
                    int ajob = scanner.nextInt(); scanner.nextLine();
                    System.out.print("Enter Applicant ID: ");
                    int aapp = scanner.nextInt(); scanner.nextLine();
                    System.out.print("Enter Cover Letter: ");
                    String cover = scanner.nextLine();
                    JobApplication application = new JobApplication(appid, ajob, aapp, LocalDateTime.now(), cover);
                    service.insertJobApplication(application);
                    System.out.println("Application submitted.");
                    break;
                case 5:
                    List<JobListing> jobs = service.getJobListings();
                    for (JobListing jl : jobs) {
                        System.out.println(jl.getCompanyID()+" "+jl.getJobDescription()+" "+jl.getJobID()+" "+jl.getJobLocation()+" "+jl.getJobTitle()+" "+jl.getJobTitle()+" "+jl.getSalary());
                    }
                    break;
                case 6:
                    List<Applicant> applicants = service.getApplicants();
                    for (Applicant a : applicants) {
                        System.out.println(a.getApplicantID()+" "+a.getFirstName()+" "+a.getEmail());
                    }
                    break;
                case 7:
                    System.out.print("Enter minimum salary: ");
                    double minSalary = scanner.nextDouble();
                    System.out.print("Enter maximum salary: ");
                    double maxSalary = scanner.nextDouble();
                    scanner.nextLine();
                    List<JobListing> salaryJobs = service.searchJobsBySalaryRange(minSalary, maxSalary);
                    for (JobListing jl : salaryJobs) {
                    	 System.out.println(jl.getCompanyID()+" "+jl.getJobDescription()+" "+jl.getJobID()+" "+jl.getJobLocation()+" "+jl.getJobTitle()+" "+jl.getJobTitle()+" "+jl.getSalary());
                    }
                    break;
                case 0:
                    System.out.println("Exiting ...");
                    break;
                default:
                    System.out.println("Invalid choice. Try again.");
            }
        } while (choice != 0);
        scanner.close();
    }
}
