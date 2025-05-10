package com.clinica.odontologia_app.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.clinica.odontologia_app.dto.UserInfoResponse;
import com.clinica.odontologia_app.entity.User;
import com.clinica.odontologia_app.repository.UserRepository;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

	private final UserRepository userRepository;

	public AuthController(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	
	@GetMapping("/userinfo")
	public ResponseEntity<UserInfoResponse> getUserInfo(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		User user = userRepository.findByUsername(username)
				.orElseThrow(() -> new RuntimeException("User not found" + username));
		
		List<String> roles = user.getRoles().stream()
				.map(role -> role.getName())
				.collect(Collectors.toList());
		return ResponseEntity.ok(new UserInfoResponse(
				user.getId(), 
				user.getUsername(), 
				roles));
	}
	
	@RestController
	@RequestMapping("/api/admin")
	class AdminController {
	    @GetMapping("/test")
	    public ResponseEntity<String> adminTest() {
	        return ResponseEntity.ok("Admin endpoint works");
	    }
	}

	@RestController
	@RequestMapping("/api/user")
	class UserController {
	    @GetMapping("/test")
	    public ResponseEntity<String> userTest() {
	        return ResponseEntity.ok("User endpoint works");
	    }
	}
}
