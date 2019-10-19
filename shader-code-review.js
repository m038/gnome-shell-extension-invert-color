function getSource(){
    return `
        uniform sampler2D tex;

        void main() {
            vec4 c = texture2D(tex, cogl_tex_coord_in[0].st);
            c = vec4(c.a + c.r*0.3333 - c.g*0.6666 - c.b*0.6666, c.a - c.r*0.6666 + c.g*0.3333 - c.b*0.6666, c.a - c.r*0.6666 - c.g*0.6666 + c.b*0.3333, c.a);
            cogl_color_out = c * cogl_color_in;
        }
    `;
} 