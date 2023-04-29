package com.example.demo.repos;

import com.example.demo.domain.Issue;
import org.springframework.data.repository.CrudRepository;

public interface IssueRepo extends CrudRepository<Issue,Long> {

}
