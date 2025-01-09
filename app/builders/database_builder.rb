class DatabaseBuilder
  def self.initialize
    for role_name in ["Admin", "Student", "Maintainer"] do
      RoleBuilder.build_role(role_name)
    end

    UserBuilder.build_user("Admin", "flashMasters Admin", "admin@flashmasters.com", "password", true)
    UserBuilder.build_user("Student", "flashMasters Student", "student@flashmasters.com", "password", false)

    questions = [
      QuestionBuilder.build_question(
        "PHP este un limbaj de programare dedicat domeniului:",
        3,
        {
          "1"  => "game development",
          "2"  =>  "AI",
          "3"  =>  "data processing",
          "4"  =>  "web development",
          "5"  =>  "inginerie"
        },
        [CardBuilder.build_card("PHP este un limbaj de programare general-purpose, dedicat in mare parte, domeniului web.")]
      ),
      QuestionBuilder.build_question(
        "Laravel este un framework pentru limbajul de programare:",
        2,
        {
          "1"  => "Python",
          "2"  =>  "Javascript",
          "3"  =>  "PHP",
          "4"  =>  "Ruby",
          "5"  =>  "Rust"
        },
        [
          CardBuilder.build_card("Laravel, este unul dintre cele mai folosite framework-uri ale PHP-ului"),
          CardBuilder.build_card("https://laracasts.com/ este o platformă ce permite învățarea framework-ului Laravel foarte facil")
        ]
      )
    ]

    BundleBuilder.build_bundle(
      "Webdev 101",
      10000,
      "Doresti sa explorezi un nou domeniu de programare? Esti la inceput de cariera? Atunci acest bundle este pentru tine! Invata elementele de baza legate de tehnologiile actuale din industria web cu un singur click!",
      "</>",
      5,
      questions
    )

    BundleBuilder.build_bundle(
      "Chimia pentru toti",
      5000,
      "Chimia este nunul dintre cele mai importante domenii stiintifice. Datorita ei, omenirea se dezvolta constant. Acest bundle iti va raspunde la intrebari precum: Cum a fost descoperit focul? Ce este tabelul elementelor chimice si cine a fost Mendelev?",
      "🔯",
      3,
      nil
    )

    BundleBuilder.build_bundle(
      "Primul tau portofoliu de investitii",
      5000,
      "Chimia este nunul dintre cele mai importante domenii stiintifice. Datorita ei, omenirea se dezvolta constant. Acest bundle iti va raspunde la intrebari precum: Cum a fost descoperit focul? Ce este tabelul elementelor chimice si cine a fost Mendelev?",
      "📈",
      3,
      nil
    )
  end
end