import unittest
from carteiropy import calculadora


class TestSum(unittest.TestCase):

    def test_soma(self):
        self.assertEqual(calculadora.soma(3,5), 8, "Should be 8")
