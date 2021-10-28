module full_add (
    input a,b,cin,
    output sum,cout
);
    wire s,carry1,carry2;
    add add_inst1(.a(a),.b(b),.sum(s),.cout(carr1));
    add add_inst2(.a(s),.b(cin),.sum(sum),.cout(carr2));
    assign cout=carry1|carry2;
endmodule