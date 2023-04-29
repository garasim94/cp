package com.example.demo.service;

import com.example.demo.domain.Issue;
import com.example.demo.domain.Status;
import com.example.demo.domain.Train;
import com.example.demo.domain.Trip;
import com.example.demo.repos.IssueRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IssueService {
    @Autowired
    private IssueRepo issueRepo;

    public Issue save(Issue issue){
        return issueRepo.save(issue);
    }
    public Issue createIssue(String message){
        Issue issue=new Issue();
        issue.setMessage(message);
        issue.setStatus(Status.UNREAD);
        return issue;
    }
    public Issue getIssueById(Long id){
        return issueRepo.findById(id).orElse(null);
    }
    public boolean changeStatus(Long id, String status) {
        Issue issue= getIssueById(id);
        if(issue==null) return false;
        switch (status) {
            case "accept":
                issue.setStatus(Status.ACCEPT) ;
                break;
            case "deny":
                issue.setStatus(Status.DENIED);
                break;
            default:
                return false;
        }
        issueRepo.save(issue);
        return true;
    }

    public void delete(Issue issue) {
        issueRepo.delete(issue);
    }
    public void deleteIssueAfterEdit(Train train){
        for(Issue issue: train.getIssues()){
            if(issue.getStatus()== Status.ACCEPT){
                delete(issue);
            }
        }
    }
    public void deleteIssueAfterEdit(Trip trip){
        for(Issue issue: trip.getIssues()){
            if(issue.getStatus()== Status.ACCEPT){
                delete(issue);
            }
        }
    }
}
