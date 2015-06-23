package com.cnblogs.yjmyzz.utils;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class VelocitySecurityUtil  extends BaseBean {

	private VelocitySecurityUtil(){
		//工具类无需对象实例化
	}

	public static String getPrincipal() {

		Object obj = SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		if (obj instanceof UserDetails) {
			return ((UserDetails) obj).getUsername();
		} else {
			return "anonymous";
		}
	}

	public static boolean isAuthenticated() {
		return !getPrincipal().equals("anonymous");
	}

	public static boolean allGranted(String[] checkForAuths) {
		Set<String> userAuths = getUserAuthorities();
		for (String auth : checkForAuths) {
			if (userAuths.contains(auth))
				continue;
			return false;
		}
		return true;
	}

	public static boolean anyGranted(String[] checkForAuths) {
		Set<String> userAuths = getUserAuthorities();
		for (String auth : checkForAuths) {
			if (userAuths.contains(auth))
				return true;
		}
		return false;
	}

	public static boolean noneGranted(String[] checkForAuths) {
		Set<String> userAuths = getUserAuthorities();
		for (String auth : checkForAuths) {
			if (userAuths.contains(auth))
				return false;
		}
		return true;
	}

	private static Set<String> getUserAuthorities() {
		Object obj = SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		Set<String> roles = new HashSet<String>();
		if (obj instanceof UserDetails) {
			@SuppressWarnings("unchecked")
			Collection<GrantedAuthority> gas = (Collection<GrantedAuthority>) ((UserDetails) obj)
					.getAuthorities();
			for (GrantedAuthority ga : gas) {
				roles.add(ga.getAuthority());
			}
		}
		return roles;
	}

}
