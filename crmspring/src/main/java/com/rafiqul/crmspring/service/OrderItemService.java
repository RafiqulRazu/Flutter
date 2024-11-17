//package com.rafiqul.crmspring.service;
//
//import com.rafiqul.crmspring.entity.OrderItem;
//import com.rafiqul.crmspring.repository.OrderItemRepository;
//import jakarta.transaction.Transactional;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//import java.util.Optional;
//
//@Service
//public class OrderItemService {
//
//    @Autowired
//    private OrderItemRepository orderItemRepository;
//
//    // Create a new OrderItem
//    public OrderItem createOrderItem(OrderItem orderItem) {
//        orderItem.setTotalPrice(calculateTotalPrice(orderItem));  // Set total price while creating
//        return orderItemRepository.save(orderItem);
//    }
//
//    // Get all OrderItems for an order
//    public List<OrderItem> getOrderItemsByOrderId(long orderId) {
//        return orderItemRepository.findByOrderId(orderId);
//    }
//
//    // Get an OrderItem by its ID
//    public OrderItem getOrderItemById(long id) {
//        Optional<OrderItem> orderItemOptional = orderItemRepository.findById(id);
//        return orderItemOptional.orElse(null);  // Return the OrderItem or null if not found
//    }
//
//    // Update an existing OrderItem
//    public OrderItem updateOrderItem(long id, OrderItem updatedOrderItem) {
//        Optional<OrderItem> existingOrderItemOptional = orderItemRepository.findById(id);
//
//        if (existingOrderItemOptional.isPresent()) {
//            OrderItem existingOrderItem = existingOrderItemOptional.get();
//            existingOrderItem.setProduct(updatedOrderItem.getProduct());
//            existingOrderItem.setQuantity(updatedOrderItem.getQuantity());
//            existingOrderItem.setUnitPrice(updatedOrderItem.getUnitPrice());
//            existingOrderItem.setVat(updatedOrderItem.getVat());
//
//            // Recalculate total price when updating the item
//            existingOrderItem.setTotalPrice(calculateTotalPrice(existingOrderItem));
//
//            return orderItemRepository.save(existingOrderItem);
//        }
//
//        return null;
//    }
//
//    // Delete an OrderItem by ID
//    public boolean deleteOrderItem(long id) {
//        Optional<OrderItem> existingOrderItemOptional = orderItemRepository.findById(id);
//        if (existingOrderItemOptional.isPresent()) {
//            orderItemRepository.deleteById(id);
//            return true;
//        }
//        return false;
//    }
//
//    // Method to calculate total price based on unit price, quantity, and VAT
//    public double calculateTotalPrice(OrderItem orderItem) {
//        double subtotal = orderItem.getUnitPrice() * orderItem.getQuantity();
//        double vatAmount = (orderItem.getVat() / 100) * subtotal;
//        return subtotal + vatAmount;
//    }
//}
