package day1PreparedStatement.entity;

/**
 * @description:
 * @author: bberzhou@gmail.com
 * @date: 6/30/2021
 * Create By Intellij IDEA
 */
public class Student {
    private int flowID;     //  流水号
    private int type;       //  考试类型
    private String IDCard;  //  身份证号
    private String examCard;//  准考证号
    private String name;    //  学生姓名
    private String location; //  所在城市
    private int grade;      //  成绩

    public Student() {
    }

    public Student(int flowID, int type, String IDCard, String examCard, String name, String location, int grade) {
        this.flowID = flowID;
        this.type = type;
        this.IDCard = IDCard;
        this.examCard = examCard;
        this.name = name;
        this.location = location;
        this.grade = grade;
    }

    @Override
    public String toString() {
        return "Student{" +
                "flowID=" + flowID +
                ", type=" + type +
                ", IDCard='" + IDCard + '\'' +
                ", examCard='" + examCard + '\'' +
                ", name='" + name + '\'' +
                ", location='" + location + '\'' +
                ", grade=" + grade +
                '}';
    }

    public int getFlowID() {
        return flowID;
    }

    public void setFlowID(int flowID) {
        this.flowID = flowID;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getIDCard() {
        return IDCard;
    }

    public void setIDCard(String IDCard) {
        this.IDCard = IDCard;
    }

    public String getExamCard() {
        return examCard;
    }

    public void setExamCard(String examCard) {
        this.examCard = examCard;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }
}
