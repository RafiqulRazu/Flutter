package com.rafiqul.crmspring.service;

import com.rafiqul.crmspring.entity.Order;
import com.rafiqul.crmspring.entity.OrderItem;
import com.rafiqul.crmspring.entity.Product;
import com.rafiqul.crmspring.entity.Task;
import com.rafiqul.crmspring.repository.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private LeadRepository leadRepository;

    @Autowired
    private ProductService productService;
    @Autowired
    private OrderItemRepository orderItemRepository;
    @Autowired
    private TaskRepository taskRepository;


    @Transactional
    public Order createOrder(Order order) {
        double totalAmount = 0.0;
        List<OrderItem> orderItems = order.getOrderItems();
        for (OrderItem orderItem : orderItems) {
            Product product = productService.getProductById(orderItem.getProduct().getId());
            product.setStock(product.getStock() - orderItem.getQuantity());
            productRepository.save(product);
            totalAmount += orderItem.getQuantity() * orderItem.getProduct().getUnitPrice();
            orderItemRepository.save(orderItem);
        }
        order.setTotalAmount(totalAmount);
        order.setStatus(Order.OrderStatus.PENDING);
        return orderRepository.save(order);
    }

    @Transactional
    public Order approveOrder(Long orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(Order.OrderStatus.APPROVED);
        Task task = taskRepository.findBySalesExecutive_Id(order.getSoldBy().getId()).orElse(null);
        if (task != null) {
            task.setSalesAmount(task.getSalesAmount() + order.getTotalAmount());
            taskRepository.save(task);
        }
        return orderRepository.save(order);
    }

    public Order getOrderById(Long orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public void deleteOrder(Long orderId) {
        orderRepository.deleteById(orderId);
    }

}
