import 'package:adhd_app/models/article.dart';

//list contains articles
// List<Article> articles = [
//   Article(
//     id: 1,
//     title: "Dealing with a child with ADHD",
//     content: 'Child Behavior Checklist Adhd',
//   ),
//   Article(
//     id: 2,
//     title: "ttt",
//     content: 'Lorem ipsum dolor',
//   ),
//   Article(
//     id: 3,
//     title: "Title 3",
//     content: 'Lorem ipsum dolor',
//   ),
// ];

// final List<ArticleModel> articleModels = [
//   ArticleModel(
//       title: 'The Importance of Exercise',
//       author: 'John Doe',
//       imageUrl: 'https://example.com/exercise.jpg',
//       subtitle: 'Why Exercise is Important for Your Health',
//       tips: [
//         'Exercise regularly to improve your physical and mental health',
//         'Choose activities that you enjoy and that fit your fitness level',
//         'Set realistic goals and track your progress',
//       ],
//       references: '1. CDC. Physical Activity and Health. '
//           'https://www.cdc.gov/physicalactivity/basics/pa-health/index.htm\n'
//           '2. Harvard Health Publishing. '
//           'Exercising to relax - Harvard Health Publishing. '
//           'https://www.health.harvard.edu/staying-healthy/exercising-to-relax',
//       articleId: '1'),
//   ArticleModel(
//       articleId: '2',
//       title: 'The Benefits of Meditation',
//       author: 'Jane Smith',
//       imageUrl: 'https://example.com/meditation.jpg',
//       subtitle: 'How Meditation Can Improve Your Life',
//       tips: [
//         'Start with short meditation sessions and gradually increase the duration',
//         'Find a quiet and comfortable place to meditate',
//         'Use guided meditations or apps to help you get started',
//       ],
//       references: '1. Harvard Health Publishing. '
//           'Meditation: A simple,fast way to reduce stress - Harvard Health Publishing. '
//           'https://www.health.harvard.edu/staying-healthy/meditation-a-simple-fast-way-to-reduce-stress\n'
//           '2. National Center for Complementary and Integrative Health. '
//           'Meditation: In Depth. '
//           'https://www.nccih.nih.gov/health/meditation-in-depth'),
//   ArticleModel(
//       articleId: '3',
//       title: 'Healthy Eating Habits',
//       author: 'Alice Johnson',
//       imageUrl: 'https://example.com/healthy-eating.jpg',
//       subtitle: 'How to Eat a Balanced and Nutritious Diet',
//       tips: [
//         'Eat a variety of fruits, vegetables, whole grains, and lean proteins',
//         'Limit processed and high-fat foods',
//         'Plan your meals ahead of time to avoid unhealthy choices',
//       ],
//       references: '1. Harvard Health Publishing. '
//           'Healthy Eating: A guide to the new nutrition - Harvard Health Publishing. '
//           'https://www.health.harvard.edu/staying-healthy/healthy-eating-a-guide-to-the-new-nutrition\n'
//           '2. Mayo Clinic. Nutrition and healthy eating. '
//           'https://www.mayoclinic.org/healthy-lifestyle/nutrition-and-healthy-eating/in-depth/healthy-eating/art-20049921'),
// ];
final dummyArticle = ArticleModel(
  imageUrl:
      'https://i.pinimg.com/564x/82/79/e6/8279e6d1586d0a702a49dffcc74a1702.jpg',
  title: 'ADHD Parenting Tips',
  author: 'By Melinda Smith, M.A. and Jeanne Segal, Ph.D.',
  subTitle: 'How to help your child with ADHD!',
  tips: [
    TipModel(
      title: 'Tip 1: Stay positive and healthy yourself',
      description:
          'As a parent, you set the stage for your child emotional and physical health. You have control over many of the factors that can positively influence the symptoms of your child disorder.',
    ),
    TipModel(
      title: 'Tip 2: Establish structure and stick to it',
      description:
          'Children with ADHD are more likely to succeed in completing tasks when the tasks occur in predictable patterns and in predictable places. Your job is to create and sustain structure in your home, so that your child knows what to expect and what they are expected to do.',
    ),
    TipModel(
      title: 'Tip 3: Encourage movement and sleep',
      description:
          'Children with ADHD often have energy to burn. Organized sports and other physical activities can help them get their energy out in healthy ways and focus their attention on specific movements and skills. The benefits of physical activity are endless: it improves concentration, decreases depression and anxiety, and promotes brain growth. Most importantly for children with attention deficits, however, is the fact that exercise leads to better sleep, which in turn canreduce ADHD symptoms during the day.',
    ),
    // Add more tips as needed
  ],
  references:
      'Smith, M., & Segal, J. (2021, May 1). ADHD Parenting Tips. HelpGuide.org. https://www.helpguide.org/articles/add-adhd/parenting-tips-for-adhd.htm',
);

// Pass the article to the ArticleScreen widget
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => ArticleScreen(article: article),
//   ),
// );
