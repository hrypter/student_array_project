package in.suman.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.suman.model.Student;

@Controller
public class StudentController {

    private final List<Student> students = new ArrayList<>();
    private long nextId = 1;

    @GetMapping("/students")
    public String getAllStudents(Model model) {
        // Sort the list in ascending order based on ID
        Collections.sort(students, Comparator.comparingLong(Student::getId));
        // Add the list of students to the model
        model.addAttribute("students", students);
        return "students";
    }

    @PostMapping("/students/new")
    @ResponseBody
    public ResponseEntity<String> saveStudent(@ModelAttribute Student student) {
        student.setId(nextId++);
        students.add(student);
        return ResponseEntity.ok("Student created successfully");
    }

    @GetMapping("/students/edit/{id}")
    @ResponseBody
    public ResponseEntity<Student> getStudentById(@PathVariable long id) {
        for (Student student : students) {
            if (student.getId() == id) {
                return ResponseEntity.ok(student);
            }
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/students/edit/{id}")
    @ResponseBody
    public ResponseEntity<String> updateStudent(@PathVariable long id, @ModelAttribute Student updatedStudent) {
        for (Student student : students) {
            if (student.getId() == id) {
                student.setFirstName(updatedStudent.getFirstName());
                student.setLastName(updatedStudent.getLastName());
                student.setEmail(updatedStudent.getEmail());
                return ResponseEntity.ok("Student updated successfully");
            }
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/students/delete/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteStudent(@PathVariable long id) {
        students.removeIf(student -> student.getId() == id);
        return ResponseEntity.ok("Student deleted successfully");
    }
}
