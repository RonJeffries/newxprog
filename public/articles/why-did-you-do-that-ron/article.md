title: Why Did You Do That, Ron?
date: Sat, 25 Jun 2011 14:35:26 +0000
category: "Articles"
slug: why-did-you-do-that-ron
link: http://xprogramming.com/articles/why-did-you-do-that-ron/
---

Piers Thompson sent me a good *question* about my recent database articles. I suspect others would like to hear the question and answers.
<blockquote>Just discovered your blog and am enjoying it. I was struck however bythe fact that your test code would not pass muster in my team. We have more test code than non-test code, so we are equally rigorous about the quality of the test case as we are the non-test code (quality insomuch as it is likely to affect the future costs of owning the code). Therefore I consider repeating yourself in test code to be almost invariably bad practice. Yet your test code is sprinkled with repeated literals. You also have subtle repetition - a test method named ..sixth... which includes six calls to member.charge.

I'm sure that you have a good reason and I wonder what it is.</blockquote>
I do have some good reasons ... some that are questionable, and some that are probably not so good at all. Let's explore the ones I'm aware of. My tabbed out comments are pretty much what I said to Piers. Tabbed in are today's feelings about that day's feelings.

First of all, the article series so far is an example of TDDing to a point early in a program. And in fact some of the things, like the literals, do get pulled out later on. The TDD cycle is red/green/refactor and one improves what one sees as one goes.

<p style="padding-left: 30px;">True enough: the focus is on getting a non-DB solution. However, there are a pile of literal small integers and they do not have meaning. I did *pull* out the person ones (not as nicely as I might have) but the value ones are not yet pulled out. They should be, and in my current version they are. I'll post that later.</p>
Recall also that this is my first-ever published Python program. AsI comment in the second article, I was doing things (like not adhering to "standard" naming) to reduce my cognitive load. Possiblythat same focus on "how the hell do I say this in Python" caused me not to notice things that I otherwise would have.

And, I didn't have anyone pairing with me to help keep me honest.

<p style="padding-left: 30px;">As an <em><strong>explanation </strong></em>of how I got where I got, I buy this. I wouldn't accept it as an <em><strong>excuse</strong></em> for being there, or for staying there. The code is not good enough for the long term, and even with a few days' experience in Python, I can see that. I don't know the Python way of making it better but I sure as hell know some ways. Again, let's see what the next version looks like.</p>
<strong>However</strong>, I actually do some of these things on purpose.

In the method Piers mentions, the six calls are necessary, as I'm sure you see, because I want to check that each of the six gets a correct answer, including the sixth, which is supposed to get zero. This would have been a better test, perhaps, if all the values had been different, but since TDD is a white-box activity, I wasn't worried about getting some number other than the input or zero. It /might/ improve the tests for the long term to change that.

The six calls could, of course, be placed in a loop, as I did with subsequent ones. There are two reasons not to do that, one not so good and the other one more to the idea of "reasons" why I do what I do.

The not so good reason was that at that moment I didn't want to figure out the looping and how to construct it. I had "call six times" in my mind and writing it out longhand was easier.

The better reason, however, is that doing the calls explicitly, rather than in a loop, tells a better story. The member buys something; he buys something later; he buys something later still; and so on. The "real world" events are not "the member is in a loop", so I prefer the code written out longhand, despite the duplication.

However, in the later, more complex tests, with multiple members making multiple purchases, I did go to the looping, and frankly I think it makes the tests harder to understand. I could imagine some heavier refactoring, such as making
<pre>    for i in range(5):
        self.assertEquals(6,member.charge(6))</pre>
into something like
<pre>    assert_member_makes_five_charges_at_cost(6)</pre>
And one could make that (6) into (SIX_DOLLARS), and probably should.

Suffice to say that I like each test to tell its own story, and so I generally do not factor out duplication as aggressively as I would in the production code. This is an example of the tension between rules two and three of  Beck's rules of Simple Code:
<ol>
	<li>Runs all the tests;</li>
	<li>Contains no duplication;</li>
	<li>Expresses all our design ideas;</li>
	<li>Minimizes number of code entities;</li>
</ol>
In the case of tests, I sometimes prefer more duplication to get better expression of the testing ideas.

For the article, this final point is also key:

<em><strong>The point of the article is to focus on how to TDD toward a database without actually doing any database work. Thus I want the code in the article to focus on the working mechanics of the production code, and on the thought process that goes into the tests. If I were to go off on a refactoring spree on the tests, I felt that would draw attention away from the core point.</strong></em>

That said, for longer-term life in a production system, the tests do need improvement. Here's what I have for those same tests today:
<pre>THREE_DOLLARS = 3
FOUR_DOLLARS = 4
FIVE_DOLLARS = 5
SIX_DOLLARS = 6
TEN_DOLLARS = 10

PERSON_ONE = 1
PERSON_TWO = 2
PERSON_SIX = 6

class NoDBTests(unittest.TestCase):

    def test_hookup(self):
        self.assertTrue(True)

    def test_member_charge(self):
        member = MemberRecord()
        charge_amount = member.charge(TEN_DOLLARS)
        self.assertEqual(TEN_DOLLARS,charge_amount)

    def test_sixth_one_free(self):
        member = MemberRecord()
        charge_amount = member.charge(FIVE_DOLLARS)
        self.assertEqual(FIVE_DOLLARS, charge_amount)
        charge_amount = member.charge(FIVE_DOLLARS)
        self.assertEqual(FIVE_DOLLARS, charge_amount)
        charge_amount = member.charge(FIVE_DOLLARS)
        self.assertEqual(FIVE_DOLLARS, charge_amount)
        charge_amount = member.charge(FIVE_DOLLARS)
        self.assertEqual(FIVE_DOLLARS, charge_amount)
        charge_amount = member.charge(FIVE_DOLLARS)
        self.assertEqual(FIVE_DOLLARS, charge_amount)
        charge_amount = member.charge(FIVE_DOLLARS)
        self.assertEqual(0, charge_amount)

    def test_twelfth_one_free(self):
        member = MemberRecord()
        for i in range(5):
            self.assertEquals(SIX_DOLLARS,member.charge(SIX_DOLLARS))
        charge_amount = member.charge(SIX_DOLLARS)
        self.assertEqual(0, charge_amount, "first one bad")
        for i in range(5):
            self.assertEquals(SIX_DOLLARS,member.charge(SIX_DOLLARS))
        charge_amount = member.charge(SIX_DOLLARS)
        self.assertEquals(0, charge_amount, "second one bad")

    def test_member_two_still_gets_free(self):
        members = MemberCollection()
        for purchase_from_two in range(5):
            self.assertEquals(FOUR_DOLLARS, members.member(PERSON_TWO).charge(FOUR_DOLLARS))
        self.assertEquals(0, members.member(PERSON_TWO).charge(FOUR_DOLLARS))

    def test_member_six_does_not_interfere_with_two(self):
        members = MemberCollection()
        for purchase_from_two in range(5):
            self.assertEquals(FOUR_DOLLARS, members.member(PERSON_TWO).charge(FOUR_DOLLARS))
        self.assertEquals(FOUR_DOLLARS, members.member(PERSON_SIX).charge(FOUR_DOLLARS), "six interfered")
        self.assertEquals(0, members.member(PERSON_TWO).charge(FOUR_DOLLARS), "two got no discount")

    def test_threeAtOnce(self):
        members = MemberCollection()
        for purchase_number in range(5):
            for person in [2, 6, 1]:
                self.assertEquals(THREE_DOLLARS, members.member(person).charge(THREE_DOLLARS), "improper free one")
        self.assertEqual(0, members.member(PERSON_ONE).charge(THREE_DOLLARS))
        self.assertEqual(0, members.member(PERSON_TWO).charge(THREE_DOLLARS))
        self.assertEqual(0, members.member(PERSON_SIX).charge(THREE_DOLLARS))</pre>&nbsp;
Of these, I like the named literals much better than the literal literals. This was Piers' first point. As for the duplicated lines versus the loops, I find the tests with the duplicated lines easier to read by a small margin. The last one, looping over five interleaved purchases for three people, is pretty hard to decode, I think. I prefer the six in a row one to a single loop of five followed by a single call to check the freebie, but it's hard to count the six. If it were "twelfth one free", in line would be bad for sure.

So let's see what else we can do. First of all, all those asserts have a log of duplication, and they're all just checking that some person pays some amount, or that some person pays nothing. Let's express that:
<pre>    <span style="color: #993300;">def check_person_pays(self, members, person, amount):
        self.assertEquals(amount, members.member(person).charge(amount))

    def check_person_free(self, members, person, amount):
        self.assertEquals(0, members.member(person).charge(amount))</span>

    def test_member_two_still_gets_free(self):
        members = MemberCollection()
        for purchase_from_two in range(5):
            self.<span style="color: #993300;">check_person_pays(members, PERSON_TWO, FOUR_DOLLARS)</span>
        self.<span style="color: #993300;">check_person_free(members, PERSON_TWO, FOUR_DOLLARS)</span>

    def test_member_six_does_not_interfere_with_two(self):
        members = MemberCollection()
        for purchase_from_two in range(5):
            self.<span style="color: #993300;">check_person_pays(members, PERSON_TWO, FOUR_DOLLARS)</span>
        self.<span style="color: #993300;">check_person_pays(members, PERSON_SIX, FOUR_DOLLARS)</span>
        self.<span style="color: #993300;">check_person_free(members, PERSON_TWO, FOUR_DOLLARS)</span>

    def test_threeAtOnce(self):
        members = MemberCollection()
        for purchase_number in range(5):
            for person in [2, 6, 1]:
                self.<span style="color: #993300;">check_person_pays(members, person, THREE_DOLLARS)</span>
        self.<span style="color: #993300;">check_person_free(members, PERSON_ONE, THREE_DOLLARS)</span>
        self.<span style="color: #993300;">check_person_free(members, PERSON_TWO, THREE_DOLLARS)</span>
        self.<span style="color: #993300;">check_person_free(members, PERSON_SIX, THREE_DOLLARS)</span></pre>
&nbsp;

I think I like that better still. We have lost my few special diagnostics, but those can readily be replaced by adding an optional argument to the check functions. Meanwhile the tests express what's going on quite a bit better.

I think this is well worth doing before committing these stories to the system. And I'm still glad that we focused first on the main point, getting the database feature working without an actual database, and then looked at improving the tests.

What do you think, Piers? And what do you all think? Thanks!Piers Thompson sent me a good question about my recent database articles. I suspect others would like to hear the question and answers.

