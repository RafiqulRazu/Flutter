package com.rafiqul.crmspring.service;

import com.rafiqul.crmspring.entity.Customer;
import com.rafiqul.crmspring.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerService {

    @Autowired
    private CustomerRepository customerRepository;


    public Customer createCustomer(Customer customer) {
        return customerRepository.save(customer);
    }


    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }


    public Optional<Customer> getCustomerById(Long id) {
        return customerRepository.findById(id);
    }


    public Customer updateCustomer(Long id, Customer updatedCustomer) {
        return customerRepository.findById(id).map(customer -> {
            customer.setName(updatedCustomer.getName());
            customer.setEmail(updatedCustomer.getEmail());
            customer.setPhone(updatedCustomer.getPhone());
            customer.setAddress(updatedCustomer.getAddress());
            customer.setCompany(updatedCustomer.getCompany());
            return customerRepository.save(customer);
        }).orElseThrow(() -> new RuntimeException("Customer not found with id " + id));
    }

    public void deleteCustomer(Long id) {
        customerRepository.deleteById(id);
    }
}
