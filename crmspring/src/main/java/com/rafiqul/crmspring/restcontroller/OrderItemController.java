//package com.rafiqul.crmspring.restcontroller;
//
//import com.rafiqul.crmspring.entity.OrderItem;
//import com.rafiqul.crmspring.service.OrderItemService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@RestController
//@RequestMapping("/api/item")
//@CrossOrigin("*")
//public class OrderItemController {
//
//
//    @Autowired
//    private OrderItemService orderItemService;
//
//    // Create a new OrderItem
//    @PostMapping("/save")
//    public ResponseEntity<OrderItem> createOrderItem(@RequestBody OrderItem orderItem) {
//        OrderItem createdOrderItem = orderItemService.createOrderItem(orderItem);
//        return new ResponseEntity<>(createdOrderItem, HttpStatus.CREATED);
//    }
//
//    // Get all OrderItems for a specific Order by Order ID
//    @GetMapping("/{orderId}")
//    public ResponseEntity<List<OrderItem>> getOrderItemsByOrderId(@PathVariable long orderId) {
//        List<OrderItem> orderItems = orderItemService.getOrderItemsByOrderId(orderId);
//        return new ResponseEntity<>(orderItems, HttpStatus.OK);
//    }
//
//    // Get a specific OrderItem by ID
//    @GetMapping("/{id}")
//    public ResponseEntity<OrderItem> getOrderItemById(@PathVariable long id) {
//        OrderItem orderItem = orderItemService.getOrderItemById(id);
//        if (orderItem != null) {
//            return new ResponseEntity<>(orderItem, HttpStatus.OK);
//        } else {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//    }
//
//    // Update an existing OrderItem
//    @PutMapping("/update/{id}")
//    public ResponseEntity<OrderItem> updateOrderItem(@PathVariable long id, @RequestBody OrderItem updatedOrderItem) {
//        OrderItem orderItem = orderItemService.updateOrderItem(id, updatedOrderItem);
//        if (orderItem != null) {
//            return new ResponseEntity<>(orderItem, HttpStatus.OK);
//        } else {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//    }
//
//    // Delete an OrderItem by ID
//    @DeleteMapping("/delete/{id}")
//    public ResponseEntity<Void> deleteOrderItem(@PathVariable long id) {
//        boolean isDeleted = orderItemService.deleteOrderItem(id);
//        if (isDeleted) {
//            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
//        } else {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//    }
//
//    // Calculate total price for a given OrderItem
//    @GetMapping("/{id}/total-price")
//    public ResponseEntity<Double> calculateTotalPriceForOrderItem(@PathVariable long id) {
//        OrderItem orderItem = orderItemService.getOrderItemById(id);
//        if (orderItem != null) {
//            double totalPrice = orderItemService.calculateTotalPrice(orderItem);
//            return new ResponseEntity<>(totalPrice, HttpStatus.OK);
//        } else {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//    }
//}
